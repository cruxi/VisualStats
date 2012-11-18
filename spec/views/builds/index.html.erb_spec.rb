require 'spec_helper'

describe "builds/index" do
  before(:each) do
    assign(:builds, [
      stub_model(Build,
        :id => 1,
        :repository_id => 2,
        :number => "Number",
        :status => 3,
        :agent => "Agent",
        :config => "MyText",
        :commit_id => 4,
        :request_id => 5,
        :state => "State",
        :language => "Language",
        :duration => 6,
        :owner_id => 7,
        :owner_type => "Owner Type",
        :result => 8,
        :previous_result => 9,
        :event_type => "Event Type"
      ),
      stub_model(Build,
        :id => 1,
        :repository_id => 2,
        :number => "Number",
        :status => 3,
        :agent => "Agent",
        :config => "MyText",
        :commit_id => 4,
        :request_id => 5,
        :state => "State",
        :language => "Language",
        :duration => 6,
        :owner_id => 7,
        :owner_type => "Owner Type",
        :result => 8,
        :previous_result => 9,
        :event_type => "Event Type"
      )
    ])
  end

  it "renders a list of builds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Agent".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Owner Type".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => "Event Type".to_s, :count => 2
  end
end
