require File.join(Rails.configuration.root,"lib/tasks/travismigrate")
include TravisMigrate

namespace :db do
	desc "Migrate builds and dependent stuff to VisualBuild"
	task travismigrate: :environment do
		do_migration(500,5)
	end
end
