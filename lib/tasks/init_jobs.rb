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
        migrate_build(build)
      end
    end
    def migrate_build(build)
      puts build.id
      jobs = build.matrix
      dimensions = Build.matrix_keys_for(build.config)
      dimensions ||= [:rvm,:env] # dirty hack as testdata is missing config
      #puts "dimensions #{dimensions}"
      jobs.each do | job |
        migrate_job(job,dimensions,build)
      end
    end

    def migrate_job(job,dimensions,build)
      ji = JobInfo.create!(
        repository_id: build.repository_id,
        job_id: job.id,
        language: job.config[:language] || "ruby",
        result: job.result,
        dimension_keys: dimensions.join(", "))
      dimensions.each do | dim |
        puts dim
        ji.dimensions.create!(
          key: dim, 
          value: job.config[dim]) if job.config[dim]
      end   
    end    
end

