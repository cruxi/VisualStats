require File.join(Rails.configuration.root,"lib/tasks/init_jobs")
include InitJobs

namespace :db do
	desc "Fill the JobInfo table"
	task jobinfo: :environment do
		do_migration(100)
	end
  desc "test drive quick migration"
  task quicktest: :environment do
    do_test_quick_migration(100,1)
  end

end
