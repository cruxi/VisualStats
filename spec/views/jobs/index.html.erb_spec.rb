require 'spec_helper'

describe "jobs/index" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
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
      ),
      stub_model(Job,
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
      )
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Source Type".to_s, :count => 2
    assert_select "tr>td", :text => "Queue".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Job".to_s, :count => 2
    assert_select "tr>td", :text => "Worker".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Owner Type".to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
  end
end
