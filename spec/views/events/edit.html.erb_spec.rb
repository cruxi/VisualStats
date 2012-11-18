require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :source_id => 1,
      :source_type => "MyString",
      :repository_id => 1,
      :event => "MyString",
      :data => "MyText"
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "input#event_source_id", :name => "event[source_id]"
      assert_select "input#event_source_type", :name => "event[source_type]"
      assert_select "input#event_repository_id", :name => "event[repository_id]"
      assert_select "input#event_event", :name => "event[event]"
      assert_select "textarea#event_data", :name => "event[data]"
    end
  end
end
