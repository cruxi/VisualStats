require 'spec_helper'

describe "repositories/index" do
  before(:each) do
    assign(:repositories, [
      stub_model(Repository,
        :name => "Name",
        :url => "Url",
        :last_duration => 1,
        :last_build_id => 2,
        :last_build_number => "Last Build Number",
        :last_build_status => 3,
        :owner_name => "Owner Name",
        :owner_email => "MyText",
        :active => false,
        :description => "MyText",
        :last_build_language => "Last Build Language",
        :last_build_duration => 4,
        :private => false,
        :owner_id => 5,
        :owner_type => "Owner Type",
        :last_build_result => 6
      ),
      stub_model(Repository,
        :name => "Name",
        :url => "Url",
        :last_duration => 1,
        :last_build_id => 2,
        :last_build_number => "Last Build Number",
        :last_build_status => 3,
        :owner_name => "Owner Name",
        :owner_email => "MyText",
        :active => false,
        :description => "MyText",
        :last_build_language => "Last Build Language",
        :last_build_duration => 4,
        :private => false,
        :owner_id => 5,
        :owner_type => "Owner Type",
        :last_build_result => 6
      )
    ])
  end

  it "renders a list of repositories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Last Build Number".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Owner Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Last Build Language".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Owner Type".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
