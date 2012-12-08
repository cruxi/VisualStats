
fn =  File.join(Rails.configuration.root,"lib/tasks/sample_data_prd.rb")
require fn
namespace :db do
	desc "Fill the database with sample data"
	task populate: :environment do
		define_sample_data
	end
end