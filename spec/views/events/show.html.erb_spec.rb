require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :source_id => 1,
      :source_type => "Source Type",
      :repository_id => 2,
      :event => "Event",
      :data => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Source Type/)
    rendered.should match(/2/)
    rendered.should match(/Event/)
    rendered.should match(/MyText/)
  end
end
