module InitJobs
    def do_migration(step = 0)
        if (step == 0)
       	 migrate_builds(Build.all)
       	else
       	  offset = 0
          going = true
          result = []
          i = 0
          while going
       	    puts "Batch #{i+=1}"
            builds = Build.limit(step).offset(offset)
            offset +=step
            going = builds.size > 0
      		migrate_builds(builds)
      	  end
        end
    end
    def migrate_builds(builds)
     	builds.each do | build |
        # eher so dann doch nicht:
        # json = Travis::Api.data(build, version: 'v2')
        json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
        vb = VisualBuild.create_from_json(json)
      end
    end
end

