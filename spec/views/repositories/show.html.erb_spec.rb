require 'spec_helper'

describe "repositories/show" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Url/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Last Build Number/)
    rendered.should match(/3/)
    rendered.should match(/Owner Name/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/Last Build Language/)
    rendered.should match(/4/)
    rendered.should match(/false/)
    rendered.should match(/5/)
    rendered.should match(/Owner Type/)
    rendered.should match(/6/)
  end
end
