require 'spec_helper'

describe "jobs/show" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :id => 1,
      :repository_id => 2,
      :commit_id => 3,
      :source_id => 4,
      :source_type => "Source Type",
      :queue => "Queue",
      :type => "Type",
      :state => "State",
      :number => "Number",
      :config => "MyText",
      :status => 5,
      :job_id => "Job",
      :worker => "Worker",
      :tags => "MyText",
      :retries => 6,
      :allow_failure => false,
      :owner_id => 7,
      :owner_type => "Owner Type",
      :result => 8
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Source Type/)
    rendered.should match(/Queue/)
    rendered.should match(/Type/)
    rendered.should match(/State/)
    rendered.should match(/Number/)
    rendered.should match(/MyText/)
    rendered.should match(/5/)
    rendered.should match(/Job/)
    rendered.should match(/Worker/)
    rendered.should match(/MyText/)
    rendered.should match(/6/)
    rendered.should match(/false/)
    rendered.should match(/7/)
    rendered.should match(/Owner Type/)
    rendered.should match(/8/)
  end
end
