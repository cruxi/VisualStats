require 'spec_helper'

describe "builds/edit" do
  before(:each) do
    @build = assign(:build, stub_model(Build,
      :id => 1,
      :repository_id => 1,
      :number => "MyString",
      :status => 1,
      :agent => "MyString",
      :config => "MyText",
      :commit_id => 1,
      :request_id => 1,
      :state => "MyString",
      :language => "MyString",
      :duration => 1,
      :owner_id => 1,
      :owner_type => "MyString",
      :result => 1,
      :previous_result => 1,
      :event_type => "MyString"
    ))
  end

  it "renders the edit build form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => builds_path(@build), :method => "post" do
      assert_select "input#build_id", :name => "build[id]"
      assert_select "input#build_repository_id", :name => "build[repository_id]"
      assert_select "input#build_number", :name => "build[number]"
      assert_select "input#build_status", :name => "build[status]"
      assert_select "input#build_agent", :name => "build[agent]"
      assert_select "textarea#build_config", :name => "build[config]"
      assert_select "input#build_commit_id", :name => "build[commit_id]"
      assert_select "input#build_request_id", :name => "build[request_id]"
      assert_select "input#build_state", :name => "build[state]"
      assert_select "input#build_language", :name => "build[language]"
      assert_select "input#build_duration", :name => "build[duration]"
      assert_select "input#build_owner_id", :name => "build[owner_id]"
      assert_select "input#build_owner_type", :name => "build[owner_type]"
      assert_select "input#build_result", :name => "build[result]"
      assert_select "input#build_previous_result", :name => "build[previous_result]"
      assert_select "input#build_event_type", :name => "build[event_type]"
    end
  end
end
