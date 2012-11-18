require 'spec_helper'

describe "commits/show" do
  before(:each) do
    @commit = assign(:commit, stub_model(Commit,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Commit/)
    rendered.should match(/Ref/)
    rendered.should match(/Branch/)
    rendered.should match(/MyText/)
    rendered.should match(/Compare Url/)
    rendered.should match(/Committer Name/)
    rendered.should match(/Committer Email/)
    rendered.should match(/Author Name/)
    rendered.should match(/Author Email/)
  end
end
