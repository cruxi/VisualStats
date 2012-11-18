require 'spec_helper'

describe "broadcasts/edit" do
  before(:each) do
    @broadcast = assign(:broadcast, stub_model(Broadcast))
  end

  it "renders the edit broadcast form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => broadcasts_path(@broadcast), :method => "post" do
    end
  end
end
