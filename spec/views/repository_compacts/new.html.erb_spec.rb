require 'spec_helper'

describe "repository_compacts/new" do
  before(:each) do
    assign(:repository_compact, stub_model(RepositoryCompact,
      :name => "MyString",
      :description => "MyString",
      :url => "MyString",
      :owner_name => "MyString"
    ).as_new_record)
  end

  it "renders new repository_compact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => repository_compacts_path, :method => "post" do
      assert_select "input#repository_compact_name", :name => "repository_compact[name]"
      assert_select "input#repository_compact_description", :name => "repository_compact[description]"
      assert_select "input#repository_compact_url", :name => "repository_compact[url]"
      assert_select "input#repository_compact_owner_name", :name => "repository_compact[owner_name]"
    end
  end
end
