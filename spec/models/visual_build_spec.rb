require 'spec_helper'
require 'support/utilities'

describe VisualBuild do

  describe "it can check on equal values" do

    let(:build_json) { read_file_to_s(__FILE__,"webhook/json/build.json") }
    it "considers equal values equal" do

      b1 = VisualBuild.create_from_json_str(build_json)
      b2 = VisualBuild.create_from_json_str(build_json)
      b1.equal_values(b2).should == true
    end
    it "considers unequal values unequal" do
      b1 = VisualBuild.create_from_json_str(build_json)
      b2 = VisualBuild.create_from_json_str(build_json)
      (b1.id == b2.id).should == false
      b2.config = "asdf"
      #b2.build_url = "asdf"
      b1.equal_values(b2).should == false
    end
    it "considers equal matrix values equal" do

      b1 = VisualBuild.create_from_json_str(build_json)
      b2 = VisualBuild.create_from_json_str(build_json)
      b1.same_matrix(b2).should == true
    end
    it "considers unequal matrix values unequal" do

      b1 = VisualBuild.create_from_json_str(build_json)
      b2 = VisualBuild.create_from_json_str(build_json)
      b2.jobs.first.destroy
      b1.same_matrix(b2).should == false
    end



  end


  describe "migration" do
    let(:build){FactoryGirl.create(:build)}
    it "should be migrated" do
      expect {VisualBuild.create_from_build_via_json(build)}.to change {VisualBuild.count}.by(1)


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
