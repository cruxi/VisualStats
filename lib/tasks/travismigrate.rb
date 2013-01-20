#require 'active_record_extensions'
module TravisMigrate
    def do_migration(step = 0, max_i = 3)
        if (step == 0)
       	 migrate_builds(Build.all)
       	else
       	  offset = 0
          going = true
          result = []
          i = 0
          build = Build.first #
          builds_table = Build.arel_table
          visualbuilds_table = VisualBuild.arel_table
          migrated_condition = builds_table[:id].eq(visualbuilds_table[:travis_id])

          newTime = Time.now
          while going
            begin
              lastTime = newTime
              newTime = Time.now
              info = "Batch #{i+=1} - offset #{offset} - #{Time.now} - #{newTime-lastTime}"
         	    puts info
              build.logger.info info
              #builds = Build.limit(step).offset(offset)

              l = Build.connection.select_all("select id from builds  where NOT EXISTS(select 1 from visual_builds WHERE travis_id = builds.id ) LIMIT #{step} OFFSET #{offset};")
              ids = l.map{|h| h["id"].to_i}
              #ids = [2539816, 2411349, 2569279, 2568826, 2568853, 2569138, 2568966, 2685628, 2569446, 2569535, 2655820, 2569767, 2571329, 2569751, 2570137, 2076539, 250559, 2571291, 2571791, 2077966, 2573560, 2573870, 2573952, 2574039, 2685824, 2574230, 2574401, 2575133, 2575610, 2656378, 2656394, 2578999, 1689047, 2579072, 1321570, 2580537, 2656706, 2581543, 2581620, 2582759, 2582819, 2582646, 2604885, 2086699, 2583125, 1793456, 2583185, 2583100, 2583098, 2583253, 2583700, 2583357, 2583345, 2583354, 2583554, 2663175, 2583988, 2584027, 2583951, 252771, 2584257, 2584304, 2584310, 2584136, 2663461, 2585188, 2685163, 2585193, 2657815, 2657900, 2585410, 2658338, 2587581, 1689311, 321147, 331465, 2093426, 2608216, 2588770, 2589671, 2589744, 2094606, 2590512, 2591730, 137887, 2590055, 2590999, 2590771, 2591213, 2591442, 1794047, 2591936, 2660055, 2660059, 2592109, 2660149, 54629, 2660196, 2592188, 2592356]
              #build.logger.info "about to read #{ids}"
              begin
                builds = Build.find(ids)
              rescue Psych::SyntaxError => e #doesn't inherit from StandardError, see https://github.com/tenderlove/psych/issues/23
                #build.logger.warn("YAML SyntaxError in one of these: (#{e})")
                #build.logger.warn("#{ids}")
                builds = []
                ids.each do |id|
                  begin
                    builds << Build.find(id)
                  rescue Psych::SyntaxError
                    build.logger.warn("Psych::SyntaxError in build id #{id}")
                  end
                end
              end
              #builds = Build.where(VisualBuild.where(migrated_condition).exists.not).skip(offset).take(step)
              #builds = builds.to_a
              puts "==#{builds.size} builds.size"
              offset +=step
              going = builds.size > 0 && ((max_i == 0) || (i < max_i))
        		  migrate_builds_via_json(builds)
            rescue => e
              build.logger.warn("Exception in Batch #{i+=1} - offset #{offset} -  #{e}")
              build.logger.warn("#{e.backtrace}")
            end
      	  end
        end
    end


    def migrate_builds_via_json(builds)
     # all_builds = []
     	builds.each do | build |
        if  VisualBuild.where(travis_id: build.id).first
          build.logger.info("build #{build.id} already migrated")
        else
          begin
              json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
              vb = VisualBuild.build_from_json(json)
              VisualBuild.cross_check(vb,build)
              vb.save
             rescue => e
            build.logger.warn("Exception migrating build #{build.id} #{e}")
            build.logger.warn("#{e.backtrace}")
          end
        end
      end
      #puts all_builds.map(&:id).inspect
      #VisualBuild.my_import all_builds
    end
end
