require 'spec_helper'

describe "repositories/new" do
  before(:each) do
    assign(:repository, stub_model(Repository,
      :name => "MyString",
      :url => "MyString",
      :last_duration => 1,
      :last_build_id => 1,
      :last_build_number => "MyString",
      :last_build_status => 1,
      :owner_name => "MyString",
      :owner_email => "MyText",
      :active => false,
      :description => "MyText",
      :last_build_language => "MyString",
      :last_build_duration => 1,
      :private => false,
      :owner_id => 1,
      :owner_type => "MyString",
      :last_build_result => 1
    ).as_new_record)
  end

  it "renders new repository form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => repositories_path, :method => "post" do
      assert_select "input#repository_name", :name => "repository[name]"
      assert_select "input#repository_url", :name => "repository[url]"
      assert_select "input#repository_last_duration", :name => "repository[last_duration]"
      assert_select "input#repository_last_build_id", :name => "repository[last_build_id]"
      assert_select "input#repository_last_build_number", :name => "repository[last_build_number]"
      assert_select "input#repository_last_build_status", :name => "repository[last_build_status]"
      assert_select "input#repository_owner_name", :name => "repository[owner_name]"
      assert_select "textarea#repository_owner_email", :name => "repository[owner_email]"
      assert_select "input#repository_active", :name => "repository[active]"
      assert_select "textarea#repository_description", :name => "repository[description]"
      assert_select "input#repository_last_build_language", :name => "repository[last_build_language]"
      assert_select "input#repository_last_build_duration", :name => "repository[last_build_duration]"
      assert_select "input#repository_private", :name => "repository[private]"
      assert_select "input#repository_owner_id", :name => "repository[owner_id]"
      assert_select "input#repository_owner_type", :name => "repository[owner_type]"
      assert_select "input#repository_last_build_result", :name => "repository[last_build_result]"
    end
  end
end
