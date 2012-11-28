require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :id => 1,
      :repository_id => 1,
      :commit_id => 1,
      :source_id => 1,
      :source_type => "MyString",
      :queue => "MyString",
      :type => "",
      :state => "MyString",
      :number => "MyString",
      :config => "MyText",
      :status => 1,
      :job_id => "MyString",
      :worker => "MyString",
      :tags => "MyText",
      :retries => 1,
      :allow_failure => false,
      :owner_id => 1,
      :owner_type => "MyString",
      :result => 1
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_id", :name => "job[id]"
      assert_select "input#job_repository_id", :name => "job[repository_id]"
      assert_select "input#job_commit_id", :name => "job[commit_id]"
      assert_select "input#job_source_id", :name => "job[source_id]"
      assert_select "input#job_source_type", :name => "job[source_type]"
      assert_select "input#job_queue", :name => "job[queue]"
      assert_select "input#job_type", :name => "job[type]"
      assert_select "input#job_state", :name => "job[state]"
      assert_select "input#job_number", :name => "job[number]"
      assert_select "textarea#job_config", :name => "job[config]"
      assert_select "input#job_status", :name => "job[status]"
      assert_select "input#job_job_id", :name => "job[job_id]"
      assert_select "input#job_worker", :name => "job[worker]"
      assert_select "textarea#job_tags", :name => "job[tags]"
      assert_select "input#job_retries", :name => "job[retries]"
      assert_select "input#job_allow_failure", :name => "job[allow_failure]"
      assert_select "input#job_owner_id", :name => "job[owner_id]"
      assert_select "input#job_owner_type", :name => "job[owner_type]"
      assert_select "input#job_result", :name => "job[result]"
    end
  end
end
