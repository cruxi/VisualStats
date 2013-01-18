module InitJobs
    def do_migration(step = 0, max_i = 3)
        if (step == 0)
       	 migrate_builds(Build.all)
       	else
       	  offset = 155*100
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
            going = builds.size > 0 #&& i < max_i
      		  migrate_builds(builds)
      	  end
        end
    end
    def migrate_builds(builds)
     	builds.each do | build |
        # eher so dann doch nicht:
        # json = Travis::Api.data(build, version: 'v2')
        if  VisualBuild.where(travis_id: build.id).first
          build.logger.info("build #{build.id} already migrated")
        else
          begin
            json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
            vb = VisualBuild.create_from_json(json)
            cross_check(vb,build)
          rescue => e
            build.logger.warn("Exception migrating build #{build.id} #{e}")
          end
        end
      end
    end

    def cross_check(visual_build,build)
      #build.logger.info("checking #{build.id}")
      build.logger.warn("matrix size unequal #{build.id}") unless build.matrix.size == visual_build.jobs.size
      build.logger.warn("languages unequal #{build.id}") unless build.matrix.first.config[:language] == visual_build.jobs.first.language
    end
end

