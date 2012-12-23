require 'spec_helper'

describe "job_compacts/show" do
  before(:each) do
    @job_compact = assign(:job_compact, stub_model(JobCompact,
      :language => "Language",
      :version => "Version",
      :allow_failure => false,
      :result => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Language/)
    rendered.should match(/Version/)
    rendered.should match(/false/)
    rendered.should match(/1/)
  end
end
