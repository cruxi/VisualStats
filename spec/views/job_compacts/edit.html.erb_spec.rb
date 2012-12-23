require 'spec_helper'

describe "job_compacts/edit" do
  before(:each) do
    @job_compact = assign(:job_compact, stub_model(JobCompact,
      :language => "MyString",
      :version => "MyString",
      :allow_failure => false,
      :result => 1
    ))
  end

  it "renders the edit job_compact form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => job_compacts_path(@job_compact), :method => "post" do
      assert_select "input#job_compact_language", :name => "job_compact[language]"
      assert_select "input#job_compact_version", :name => "job_compact[version]"
      assert_select "input#job_compact_allow_failure", :name => "job_compact[allow_failure]"
      assert_select "input#job_compact_result", :name => "job_compact[result]"
    end
  end
end
