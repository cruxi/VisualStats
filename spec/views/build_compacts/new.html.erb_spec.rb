require 'spec_helper'

describe "build_compacts/new" do
  before(:each) do
    assign(:build_compact, stub_model(BuildCompact,
      :result => 1,
      :number => 1,
      :config => "MyString"
    ).as_new_record)
  end

  it "renders new build_compact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => build_compacts_path, :method => "post" do
      assert_select "input#build_compact_result", :name => "build_compact[result]"
      assert_select "input#build_compact_number", :name => "build_compact[number]"
      assert_select "input#build_compact_config", :name => "build_compact[config]"
    end
  end
end
