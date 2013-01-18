require 'spec_helper'
require 'support/utilities'

describe VisualBuildMigrationHelper do
  describe "both migration types" do
    let(:build){FactoryGirl.create(:build_with_matrix)}
    let(:job1){FactoryGirl.create(:job1, repository: build.repository, commit: build.commit, source: nil )}
    it "yield the same result" do
      b1 = VisualBuild.create_from_build_via_json(build)
      b2 = VisualBuild.create_from_build(build)
      b1.equal_values(b2).should == true

    end
    it "yield the same jobs" do
      #j = job1 argggh. giving up on trying that.
      b1 = VisualBuild.create_from_build_via_json(build)
      b2 = VisualBuild.create_from_build(build)

      b1.equal_values(b2).should == true
      b1.diff_attributes(b2).should == []
    end
  end


end
