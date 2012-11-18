require 'spec_helper'

describe "artifacts/new" do
  before(:each) do
    assign(:artifact, stub_model(Artifact,
      :id => 1,
      :content => "MyText",
      :job_id => 1
    ).as_new_record)
  end

  it "renders new artifact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artifacts_path, :method => "post" do
      assert_select "input#artifact_id", :name => "artifact[id]"
      assert_select "textarea#artifact_content", :name => "artifact[content]"
      assert_select "input#artifact_job_id", :name => "artifact[job_id]"
    end
  end
end
