require 'spec_helper'

describe "events/index" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :source_id => 1,
        :source_type => "Source Type",
        :repository_id => 2,
        :event => "Event",
        :data => "MyText"
      ),
      stub_model(Event,
        :source_id => 1,
        :source_type => "Source Type",
        :repository_id => 2,
        :event => "Event",
        :data => "MyText"
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Source Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Event".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
