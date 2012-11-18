require 'spec_helper'

describe "broadcasts/index" do
  before(:each) do
    assign(:broadcasts, [
      stub_model(Broadcast),
      stub_model(Broadcast)
    ])
  end

  it "renders a list of broadcasts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
