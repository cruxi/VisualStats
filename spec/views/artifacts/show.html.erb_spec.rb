require 'spec_helper'

describe "artifacts/show" do
  before(:each) do
    @artifact = assign(:artifact, stub_model(Artifact,
      :id => 1,
      :content => "MyText",
      :job_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
  end
end
