require 'spec_helper'

describe "repository_compacts/index" do
  before(:each) do
    assign(:repository_compacts, [
      stub_model(RepositoryCompact,
        :name => "Name",
        :description => "Description",
        :url => "Url",
        :owner_name => "Owner Name"
      ),
      stub_model(RepositoryCompact,
        :name => "Name",
        :description => "Description",
        :url => "Url",
        :owner_name => "Owner Name"
      )
    ])
  end

  it "renders a list of repository_compacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Owner Name".to_s, :count => 2
  end
end
