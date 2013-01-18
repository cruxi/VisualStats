#require 'active_record_extensions'
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
      		  migrate_builds_via_json(builds)
      	  end
        end
    end
    def migrate_builds_via_json(builds)
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

  # def cross_check(visual_build,build)
  #   #build.logger.info("checking #{build.id}")
  #   build.logger.warn("matrix size unequal #{build.id}") unless build.matrix.size == visual_build.jobs.size
  #   build.logger.warn("languages unequal #{build.id}") unless build.matrix.first.config[:language] == visual_build.jobs.first.language
  # end

    def do_quick_migration(step = 0, max_i = 3)
        if (step == 0)
         migrate_builds(Build.all)
        else
          offset = 110000
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
            #test_quick_migrate_builds(builds)
            quick_migrate_builds(builds)
          end
        end
    end
    def test_quick_migrate_builds(builds)
      builds.each do | build |
        if  VisualBuild.where(travis_id: build.id).first
          build.logger.info("build #{build.id} already migrated")
        else
          begin
            build.logger.info("test migrating build #{build.id}")
            ActiveRecord::Base.transaction do
              b1 = VisualBuild.create_from_build_via_json(build)
              b2 = VisualBuild.create_from_build(build)
#              puts "=================="
#              puts "b1.language #{b1.language}"
#              puts "b2.language #{b2.language}"
#              puts "build.language #{build.language}"
#              puts "=================="
              ok1 = VisualBuild.cross_check(b1,build,"json")
              ok2 = VisualBuild.cross_check(b2,build,"quick")
              ok = ok1 && ok2


              unless (diff = b1.diff_attributes(b2)) == []
                build.logger.warn("diff #{build.id}: #{diff}")
                ok = false
              end

              b1.jobs.each do | j1 |
                j2 =  VisualJob.where(build_id: b2.id, number: j1.number).first
                unless (diff = j1.diff_attributes(j2,["build_id"])) == []
                  build.logger.warn("diff job #{j1.number} / #{build.id}: #{diff}")
                  ok = false
                end
              end

              b2.destroy
              raise ActiveRecord::Rollback unless ok

            end
          rescue => e
            build.logger.warn("Exception migrating build #{build.id} #{e}")
            build.logger.warn("#{pp e.backtrace}")

          end
        end
      end
    end

def quick_migrate_builds(builds)
      builds.each do | build |
        if  VisualBuild.where(travis_id: build.id).first
          build.logger.info("build #{build.id} already migrated")
        else
          begin
            ActiveRecord::Base.transaction do
              b2 = VisualBuild.create_from_build(build)
              ok = VisualBuild.cross_check(b2,build,"quick")
              raise ActiveRecord::Rollback unless ok
            end
          rescue => e
            build.logger.warn("Exception migrating build #{build.id} #{e}")
            build.logger.warn("#{e.backtrace}")

          end
        end
      end
    end


end

