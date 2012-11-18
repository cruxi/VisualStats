require 'spec_helper'

describe "commits/index" do
  before(:each) do
    assign(:commits, [
      stub_model(Commit,
        :repository_id => 1,
        :commit => "Commit",
        :ref => "Ref",
        :branch => "Branch",
        :message => "MyText",
        :compare_url => "Compare Url",
        :committer_name => "Committer Name",
        :committer_email => "Committer Email",
        :author_name => "Author Name",
        :author_email => "Author Email"
      ),
      stub_model(Commit,
        :repository_id => 1,
        :commit => "Commit",
        :ref => "Ref",
        :branch => "Branch",
        :message => "MyText",
        :compare_url => "Compare Url",
        :committer_name => "Committer Name",
        :committer_email => "Committer Email",
        :author_name => "Author Name",
        :author_email => "Author Email"
      )
    ])
  end

  it "renders a list of commits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Commit".to_s, :count => 2
    assert_select "tr>td", :text => "Ref".to_s, :count => 2
    assert_select "tr>td", :text => "Branch".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Compare Url".to_s, :count => 2
    assert_select "tr>td", :text => "Committer Name".to_s, :count => 2
    assert_select "tr>td", :text => "Committer Email".to_s, :count => 2
    assert_select "tr>td", :text => "Author Name".to_s, :count => 2
    assert_select "tr>td", :text => "Author Email".to_s, :count => 2
  end
end
