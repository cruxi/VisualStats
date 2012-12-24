require 'spec_helper'


describe VisualJob do

  describe "initialization from json" do
    let(:build_failed_json) {
      dir = File.dirname(__FILE__)
      json = File.open(File.join(dir,"json/build_failed.json")).read
      json
    }
    let(:visual_build_failed){ VisualBuild.create_from_json(build_failed_json) }
    let(:visual_build_failed2){ VisualBuild.create_from_json(build_failed_json) }
    describe "creates jobs" do
       subject { visual_build_failed.jobs.first }
       describe "with fields" do
          its(:id) { should == 3628507 }
          its(:repository_id) { should == 366197 }
          its(:number) { should == "16.1" }
          its(:state) { should == "finished" }
          its(:result) { should == 1 }
          its(:finished_at) { should == "2012-12-12T13:47:48Z" }
          its(:build) { should == visual_build_failed }
          its(:dimensions) { should == {rvm: "1.9.3",env:"DB=sqlite" } }
          its(:allow_failures) { should == false }
      end
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
end
