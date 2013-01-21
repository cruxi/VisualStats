require File.join(Rails.configuration.root,"lib/tasks/travismigrate")
include TravisMigrate

namespace :db do
	desc "Migrate builds and dependent stuff to VisualBuild"
	task travismigrate: :environment do
		do_migration(100,0)
	end
  desc "Migrate builds and dependent stuff to VisualBuild"
  task benchmarkquery: :environment do
    do_benchmarkquery
  end
  desc "Migrate list of ids manually given in script"
  task manualmigration: :environment do
    do_manual_migration
  end
end



def do_benchmarkquery
  builds_table = Build.arel_table
  visualbuilds_table = VisualBuild.arel_table
  migrated_condition = builds_table[:id].eq(visualbuilds_table[:travis_id])
#  Build.where(VisualBuild.where(migrated_condition).exists.not).count

  step = 100
  offset = 300000

  start = Time.now
  builds2 = Build.limit(step).offset(offset)
  puts "straight took #{Time.now-start}"
  start = Time.now
  #builds1 = Build.where(VisualBuild.where(migrated_condition).exists.not).skip(offset).take(step)
  l = Build.connection.select_all("select id from builds  where NOT EXISTS(select 1 from visual_builds WHERE travis_id = builds.id ) LIMIT #{step} OFFSET #{offset};")
  ids = l.map{|h| h["id"].to_i}
  builds = Build.find(ids)
  puts "condition took #{Time.now-start}"



#  result = Benchmark.compare_realtime {
#    do_something_one_way
#  }.with {
#    do_it_another_way
#  }
#  Benchmark.report_on result
end


