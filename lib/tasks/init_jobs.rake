require File.join(Rails.configuration.root,"lib/tasks/init_jobs")
include InitJobs

namespace :db do
	desc "Fill the JobInfo table"
	task jobinfo: :environment do
		do_migration(10)
	end
end