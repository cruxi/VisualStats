#require 'active_record_extensions'
module TravisMigrate
    def do_migration(step = 0, max_i = 3)
        if (step == 0)
       	 migrate_builds(Build.all)
       	else
       	  offset = 52210
          going = true
          result = []
          i = 0
          newTime = Time.now
          while going
            lastTime = newTime
            newTime = Time.now
       	    puts "Batch #{i+=1} - offset #{offset}- #{Time.now} - #{newTime-lastTime}"
            builds = Build.limit(step).offset(offset)
            offset +=step
            going = builds.size > 0 && ((max_i == 0) || (i < max_i))
      		  migrate_builds_via_json(builds)
      	  end
        end
    end
    def migrate_builds_via_json(builds)
      all_builds = []
     	builds.each do | build |
        if  VisualBuild.where(travis_id: build.id).first
          build.logger.info("build #{build.id} already migrated")
        else
          begin
              json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
              vb = VisualBuild.build_from_json(json)
              VisualBuild.cross_check(vb,build)
              all_builds << vb
              #vb.save
          rescue => e
            build.logger.warn("Exception migrating build #{build.id} #{e}")
            build.logger.warn("#{e.backtrace}")
          end
        end
      end
      #puts all_builds.map(&:id).inspect
      VisualBuild.import all_builds
    end
end
