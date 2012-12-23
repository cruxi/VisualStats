require 'spec_helper'

describe "job_compacts/index" do
  before(:each) do
    assign(:job_compacts, [
      stub_model(JobCompact,
        :language => "Language",
        :version => "Version",
        :allow_failure => false,
        :result => 1
      ),
      stub_model(JobCompact,
        :language => "Language",
        :version => "Version",
        :allow_failure => false,
        :result => 1
      )
    ])
  end

  it "renders a list of job_compacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
