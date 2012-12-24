require 'spec_helper'

describe "Visual Model Associations:" do
   it "a repository has many builds" do
      rep = VisualRepository.create
      build = rep.builds.build
      build.save
      build.repository.should == rep
   end
   it "a build has many jobs" do
      build = VisualBuild.create
      job1 = build.jobs.create
      job2 = build.jobs.create
      build.jobs.size.should == 2
      job1.build.should == build
      job2.build.should == build
    end
    it "a job has many dimensions" do
      job = VisualJob.create
      d1 = job.dimensions.create
      d2 = job.dimensions.create
      d3 = job.dimensions.create
      d3.job.should == job
    end
end
