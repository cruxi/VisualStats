require 'spec_helper'

describe "repository_compacts/show" do
  before(:each) do
    @repository_compact = assign(:repository_compact, stub_model(RepositoryCompact,
      :name => "Name",
      :description => "Description",
      :url => "Url",
      :owner_name => "Owner Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/Url/)
    rendered.should match(/Owner Name/)
  end
end
