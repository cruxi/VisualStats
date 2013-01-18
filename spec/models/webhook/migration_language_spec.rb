require 'spec_helper'
require 'support/utilities'

describe VisualBuild do

  describe "initialization from json" do
    let(:build_1) { read_file_to_s(__FILE__,"json/language_check_1.json") }
    let(:visual_build_1){ VisualBuild.create_from_json_str(build_1) }
     let(:build_2) { read_file_to_s(__FILE__,"json/language_check_2.json") }
    let(:visual_build_2){ VisualBuild.create_from_json_str(build_2) }
   describe "language" do
      subject{ visual_build_1 }

    its(:language) {should ==  "node_js"}
      it "in jobs" do
       visual_build_1.jobs.each do | job|
        job.language.should == "node_js"
      end
    end
    describe "check_2" do
      it "build" do
        visual_build_2.language.should == "python"
      end
      it "in jobs" do
        visual_build_2.jobs.each do | job|
          job.language.should == "python"
        end
      end
    end
  end
  end
end
