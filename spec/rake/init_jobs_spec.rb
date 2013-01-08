require 'spec_helper'
require File.join("#{Rails.configuration.root}","lib/tasks/init_jobs")
#include InitJobs

describe "init_jobs rake task" do
  pending
 # let(:request) {FactoryGirl.create(:request)}
 # let(:build) {FactoryGirl.create(:build)}
  #let(:repository) {FactoryGirl.create(:repository)}
  let(:job) {FactoryGirl.create(:test)}
  it "job should be migrated" do
    pending

    build = Factory(:build, result: 1, commit: Factory(:commit, branch: 'master'))

    expect do
      migrate_job(job,[:rvm,:env],build)
    end.to  change(JobInfo, :count).by(1)
  end
end
