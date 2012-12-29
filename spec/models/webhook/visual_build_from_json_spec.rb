require 'spec_helper'
require 'support/utilities'


describe VisualBuild do

  describe "initialization from json" do
    let(:build_failed_json) {
      read_file_to_s(__FILE__,"json/build_failed.json")
    }
    let(:visual_build_failed){ VisualBuild.create_from_json(build_failed_json) }
    let(:visual_build_failed2){ VisualBuild.create_from_json(build_failed_json) }
    describe "creates build" do
       subject{ visual_build_failed }

       describe "sets fields in build: " do
          #its(:id) { should == 3628506}
          its(:result) {should ==          1}
          its(:number) {should ==          "16"}
          its(:started_at) {should ==      "2012-12-12T13:47:23Z"}
          its(:finished_at) {should ==     "2012-12-12T13:47:56Z"}
          its(:duration) {should ==        95}
          its(:build_url) {should ==       "https://travis-ci.org/bkleinen/VisualStats/builds/3628506"}
          its(:commit) {should ==          "e55398dd8686ea02f96c506b69da09726852464b"}
          its(:branch) {should ==          "master"}
          its(:committed_at) {should ==    "2012-12-12T13:46:28Z"}
          its(:author_name) {should ==     "Dr Blinken"}
          its(:committer_name) {should ==  "Dr Blinken"}

         # status is deprecated, we shouldn't use it at all
         #its(:status) {should ==          1}
         # further fields probably not needed for visualization
         #its(:status_message) {should ==  "Failed"}
         #its(:result_message) {should ==  "Failed"}
         #its(:message) {should ==        "updated Gemfile to pick up new gh and travis-core from VisualTravis"}
         #its(:compare_url) {should ==    "https://github.com/bkleinen/VisualStats/compare/bbc433fffb5b...e55398dd8686"}
         #its(:author_email) {should ==    "drblinken@gmail.com"}
         #its(:committer_email) {should == "drblinken@gmail.com"}
       end
       describe "sets fields from the build config" do
         #"language":"ruby",
         its(:language) {should == "ruby"}
         # das ist quatsch das ergibt sich später aus den assoz. objekten
        # its(:dimensions) {should == "rvm, env"}
         #its(:allow_failures) { should == [{"rvm" => "2.0.0"}] }
       end
       describe "other" do
         it "should handle existing ids somehow" do
          pending
           visual_build_failed.save
           expect {visual_build_failed2.save}.to raise_error (ActiveRecord::StatementInvalid)
         end
       end
    end
    describe "jobs" do
       subject{ visual_build_failed.jobs }
       describe "should all be created" do
        its(:size) {should == 4}
       end

    end
  end
end
