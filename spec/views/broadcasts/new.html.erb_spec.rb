require 'spec_helper'

describe "broadcasts/new" do
  before(:each) do
    assign(:broadcast, stub_model(Broadcast).as_new_record)
  end

  it "renders new broadcast form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => broadcasts_path, :method => "post" do
    end
  end
end
