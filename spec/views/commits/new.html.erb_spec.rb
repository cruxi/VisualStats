require 'spec_helper'

describe "commits/new" do
  before(:each) do
    assign(:commit, stub_model(Commit,
      :repository_id => 1,
      :commit => "MyString",
      :ref => "MyString",
      :branch => "MyString",
      :message => "MyText",
      :compare_url => "MyString",
      :committer_name => "MyString",
      :committer_email => "MyString",
      :author_name => "MyString",
      :author_email => "MyString"
    ).as_new_record)
  end

  it "renders new commit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => commits_path, :method => "post" do
      assert_select "input#commit_repository_id", :name => "commit[repository_id]"
      assert_select "input#commit_commit", :name => "commit[commit]"
      assert_select "input#commit_ref", :name => "commit[ref]"
      assert_select "input#commit_branch", :name => "commit[branch]"
      assert_select "textarea#commit_message", :name => "commit[message]"
      assert_select "input#commit_compare_url", :name => "commit[compare_url]"
      assert_select "input#commit_committer_name", :name => "commit[committer_name]"
      assert_select "input#commit_committer_email", :name => "commit[committer_email]"
      assert_select "input#commit_author_name", :name => "commit[author_name]"
      assert_select "input#commit_author_email", :name => "commit[author_email]"
    end
  end
end
