require 'spec_helper'

describe "build_compacts/index" do
  before(:each) do
    assign(:build_compacts, [
      stub_model(BuildCompact,
        :result => 1,
        :number => 2,
        :config => "Config"
      ),
      stub_model(BuildCompact,
        :result => 1,
        :number => 2,
        :config => "Config"
      )
    ])
  end

  it "renders a list of build_compacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Config".to_s, :count => 2
  end
end
