require 'spec_helper'

describe VisualJob do

  describe "initialization from json" do
    let(:build_failed_json) {
      read_file_to_s(__FILE__,"json/build_failed.json")
    }
    let(:visual_build_failed){ VisualBuild.create_from_json(build_failed_json) }
    let(:visual_build_failed2){ VisualBuild.create_from_json(build_failed_json) }
    describe "jobs" do
      it "creates 4 jobs" do
        visual_build_failed.jobs.size.should == 4
      end
    end
    describe "creates jobs" do
       subject { visual_build_failed.jobs.first }
       describe "with fields" do
          its(:travis_id) { should == 3628507 }
         # its(:repository_id) { should == 366197 }
          its(:number) { should == "16.1" }
          its(:state) { should == "finished" }
          its(:result) { should == 1 }
          its(:finished_at) { should == "2012-12-12T13:47:48Z" }
          its(:build) { should == visual_build_failed }
          its(:allow_failures) { should == false }
    # its(:dimensions) { should == {rvm: "1.9.3",env:"DB=sqlite" } }
      it "should preserve the original ids - at least for build"
         # its(:id) { should == 3628507 }


      end
      it "handles missing fields gracefully"
      it "logs a warning if a field is missing"
      it "should preserve the original ids - at least for build"
    end
 describe "dimensions" do
      it "should be 2" do
        d = visual_build_failed.jobs.first.dimensions
        e = [VisualDimension.kv(:rvm,"1.9.3"),
         VisualDimension.kv(:env,"DB=sqlite")]
        ((d[0].equalsDimension(e[0]) && d[1].equalsDimension(e[1])) ||
        (d[0].equalsDimension(e[1]) && d[1].equalsDimension(e[0]))).should == true
      end
    end
  end
  describe "allow failures" do
    let (:job_json) {read_file_to_json(__FILE__,"json/single_job.json")}
    let (:job) { job = VisualJob.new; job.init_from_json(job_json)}
    describe "" do
      subject{job}
      its(:allow_failures) { should == true }
    end
  end
end
