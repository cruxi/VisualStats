require 'spec_helper'
require 'support/utilities'

describe VisualBuild do

  describe "migration" do
    let(:build){FactoryGirl.create(:build)}
    it "should be migrated" do


    end
  end




  describe "should destroy dependent objects" do
    # be lazy and use a json generated visual_build as sut
    let(:build_json) { read_file_to_s(__FILE__,"webhook/json/build.json") }
    let(:visual_build){ VisualBuild.create_from_json_str(build_json) }


    it "should leave the number of builds untouched" do
      expect {vb = visual_build ; vb.destroy}.to change{VisualBuild.count}.by(0)
    end
    it "should leave the number of jobs untouched" do
      expect {vb = visual_build ; vb.destroy}.to change{VisualJob.count}.by(0)
    end
    it "should leave the number of dimensions untouched" do
      expect {vb = visual_build ; vb.destroy}.to change{VisualDimension.count}.by(0)
    end


    describe "double check that the counts are increased by creating" do
      specify "creating it should increase the build number" do
        expect {vb = visual_build }.to change{VisualBuild.count}.by(1)
      end
      specify "creating it should increase the job number" do
        expect {vb = visual_build }.to change{VisualJob.count}.by(4)
      end
      specify "creating it should increase the dimension count" do
        expect {vb = visual_build }.to change{VisualDimension.count}.by(8)
      end
    end


  end
end
