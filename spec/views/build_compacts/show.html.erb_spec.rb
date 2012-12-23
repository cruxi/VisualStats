require 'spec_helper'

describe "build_compacts/show" do
  before(:each) do
    @build_compact = assign(:build_compact, stub_model(BuildCompact,
      :result => 1,
      :number => 2,
      :config => "Config"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Config/)
  end
end
