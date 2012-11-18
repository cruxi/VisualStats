require 'spec_helper'

describe "artifacts/edit" do
  before(:each) do
    @artifact = assign(:artifact, stub_model(Artifact,
      :id => 1,
      :content => "MyText",
      :job_id => 1
    ))
  end

  it "renders the edit artifact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artifacts_path(@artifact), :method => "post" do
      assert_select "input#artifact_id", :name => "artifact[id]"
      assert_select "textarea#artifact_content", :name => "artifact[content]"
      assert_select "input#artifact_job_id", :name => "artifact[job_id]"
    end
  end
end
