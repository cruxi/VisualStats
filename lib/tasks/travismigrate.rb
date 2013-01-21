#require 'active_record_extensions'

require File.join(Rails.configuration.root,"lib/tasks/travismigrate_overwrite")

module TravisMigrate
  def do_migration(step = 0, max_i = 3)
    $logger = Build.first.logger

    if (step == 0)
    	 migrate_builds(Build.all)
    else
      offset = 0 # 83800
      going = true
      result = []
      i = 0
      builds_table = Build.arel_table
      visualbuilds_table = VisualBuild.arel_table
      migrated_condition = builds_table[:id].eq(visualbuilds_table[:travis_id])
      puts "starting migration at offset #{offset} step #{step}"
      newTime = Time.now
      while going
        lastTime = newTime
        newTime = Time.now

        info = "Batch #{i+=1} - offset #{offset} - #{Time.now} - #{newTime-lastTime}"
     	  offset +=step
        puts info
        $logger.info info

        # without regarding MigrationErrors
        #l = Build.connection.select_all("select id from builds  where NOT EXISTS(select 1 from visual_builds WHERE travis_id = builds.id ) LIMIT #{step} OFFSET #{offset};")
        # with MigrationErrors
        l = Build.connection.select_all("select id from builds  where NOT EXISTS(select 1 from visual_builds WHERE travis_id = builds.id ) AND NOT EXISTS(select 1 from migration_errors WHERE travis_id = builds.id ) LIMIT #{step} OFFSET #{offset};")
        ids = l.map{|h| h["id"].to_i}
        going = ids.size > 0 && ((max_i == 0) || (i < max_i))
        puts "ids size #{ids.size}"
        migrate_builds_with_ids(ids)
      end
    end
  end

    def do_manual_migration
     $logger = Build.first.logger
     ids = []
     # Issue1
     # ids = MigrationError.all.select{|m|/t convert nil into String/.match(m.message)}.map(&:travis_id)
     # ids = ids.reject{|i|VisualBuild.find_by_travis_id(i) }
     # Issue2
      #ids = MigrationError.all.select{|m|/undefined method `key' for nil:NilClass/.match(m.message)}.map(&:travis_id)
      #ids = ids.reject{|i|VisualBuild.find_by_travis_id(i) }
      ids = [2707162]
      puts "#{ids}"
      puts "#{ids.size}"
      puts "the idea is to manualy insert the ids in #{__FILE__}" if ids.size == 0
      migrate_builds_with_ids(ids)
    end


    def migrate_builds_with_ids(ids)
      begin
        begin
          builds = Build.find(ids)
        rescue Psych::SyntaxError => e #doesn't inherit from StandardError, see https://github.com/tenderlove/psych/issues/23
          builds = find_builds_one_by_one(ids)
        end
        migrate_builds_via_json(builds)
      rescue => e
        $logger.warn("Exception in Batch #{i+=1} - offset #{offset} -  #{e}")
        $logger.warn("#{e.backtrace}")
      end
    end

    def find_builds_one_by_one(ids)
      builds = []
        ids.each do |id|
          begin
            builds << Build.find(id)
          rescue Psych::SyntaxError
            message = "Psych::SyntaxError in build id #{id}"
            $logger.warn(message)
            MigrationError.create(travis_id: id, message: message, stackrace: "#{e.backtrace}")
          end
        end
      builds
    end


    def migrate_builds_via_json(builds)
     # all_builds = []
     	builds.each do | build |
        if  VisualBuild.where(travis_id: build.id).first
          $logger.info("build #{build.id} already migrated")
        else
          begin
              json = Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
              vb = VisualBuild.build_from_json(json)
              VisualBuild.cross_check(vb,build)
              vb.save
          rescue => e
              message = "Exception migrating build #{build.id} #{e}"
              $logger.warn(message)
              $logger.warn("#{e.backtrace}")
              MigrationError.create(travis_id: build.id, message: message, stackrace: "#{e.backtrace}")
          end
        end
      end
      #puts all_builds.map(&:id).inspect
      #VisualBuild.my_import all_builds
    end
end
