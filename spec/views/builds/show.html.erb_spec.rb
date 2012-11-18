require 'spec_helper'

describe "builds/show" do
  before(:each) do
    @build = assign(:build, stub_model(Build,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Number/)
    rendered.should match(/3/)
    rendered.should match(/Agent/)
    rendered.should match(/MyText/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/State/)
    rendered.should match(/Language/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/Owner Type/)
    rendered.should match(/8/)
    rendered.should match(/9/)
    rendered.should match(/Event Type/)
  end
end
