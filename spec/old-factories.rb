FactoryGirl.define do
  factory :repository do
    sequence(:name)  { |n| "testdummy-no#{n}"}
    #url "https://github.com/drblinken/#{name}"
    last_duration nil
    created_at "2012-03-19 10:44:54"
    updated_at "2012-10-19 08:31:21" 
    last_build_id 2850247
    last_build_number "59"
    last_build_started_at "2012-10-19 08:29:06"
    last_build_finished_at "2012-10-19 08:31:21"
    owner_name "drblinken"
    owner_email nil
    active true
    description "Description of Dummy Repository"
    last_build_language nil
    last_build_duration 565 
    private false 
    owner_id 7085 
    owner_type "User" 
    last_build_result 0
  end

  factory :request do
    repository  
   # repository_id repository.id
    commit_id 633297
    state "started"
    source nil
    payload {
      {"pusher"=>{"name"=>"drblinken",
      "email"=>"fedoronchuk@gmail.com"}, 
      "repository"=>{"name"=>"activeresource-response", 
        "size"=>208, "created_at"=>"2012-02-15T08: 34:16-08:00",
 
        "has_wiki"=>true, "private"=>false, "watchers"=>8, 
        "fork"=>false, "url"=>"https: //github.com/Fivell/activeresource-response",
 
        "language"=>"Ruby", "pushed_at"=>"2012-08-31T16: 33:23-07:00",
 
        "has_downloads"=>true, "open_issues"=>0, "has_issues"=>true,
         "homepage"=>"https: //rubygems.org/gems/activeresource-response",

          "description"=>"Extensions to ActiveResource library. The simpliest way for REST pagination.", 
          "forks"=>2, "stargazers"=>8, "owner"=>{"name"=>"Fivell", "email"=>"fedoronchuk@gmail.com"}}, 
          "forced"=>false, "head_commit"=>{"added"=>[], "modified"=>["lib/active_resource_response.rb", 
            "lib/active_resource_response/connection.rb", "lib/active_resource_response/http_response.rb",
             "lib/active_resource_response/response.rb", "lib/active_resource_response/response_method.rb", 
             "lib/active_resource_response/version.rb", "lib/activeresource-response.rb"], 
             "timestamp"=>"2012-08-31T16: 32:31-07:00",
 "removed"=>[], 
             "author"=>{"name"=>"Igor", "username"=>"Fivell", "email"=>"fedoronchuk@gmail.com"},
              "url"=>"https: //github.com/Fivell/activeresource-response/commit/5e4bd7b35200d2c4e80c32cb7f887272943c7e4f",
 
              "id"=>"5e4bd7b35200d2c4e80c32cb7f887272943c7e4f", "distinct"=>true, "message"=>"licence comments", 
              "committer"=>{"name"=>"Igor", "username"=>"Fivell", "email"=>"fedoronchuk@gmail.com"}}, 
              "after"=>"5e4bd7b35200d2c4e80c32cb7f887272943c7e4f", "deleted"=>false, "commits"=>[{"added"=>[],
               "modified"=>["lib/active_resource_response.rb", "lib/active_resource_response/connection.rb", 
                "lib/active_resource_response/http_response.rb", "lib/active_resource_response/response.rb",
                 "lib/active_resource_response/response_method.rb", "lib/active_resource_response/version.rb", 
                 "lib/activeresource-response.rb"], "timestamp"=>"2012-08-31T16: 32:31-07:00",
 "removed"=>[], 
                 "author"=>{"name"=>"Igor", "username"=>"Fivell", "email"=>"fedoronchuk@gmail.com"}, 
                 "url"=>"https: //github.com/Fivell/activeresource-response/commit/5e4bd7b35200d2c4e80c32cb7f887272943c7e4f",

                  "id"=>"5e4bd7b35200d2c4e80c32cb7f887272943c7e4f", "distinct"=>true, "message"=>"licence comments", 
                  "committer"=>{"name"=>"Igor", "username"=>"Fivell", "email"=>"fedoronchuk@gmail.com"}}], 
                  "ref"=>"refs/heads/master", "before"=>"4da33b9f41dc427b6ba0a7b44903a9d47163f1c5",
                   "compare"=>"https: //github.com/Fivell/activeresource-response/compare/4da33b9f41dc...5e4bd7b35200",
 "created"=>false} }


    token nil
    config do 
      {"language"=>"ruby", 
        "rvm"=>["1.9.3", "1.9.2", 
          "jruby-18mode", "jruby-19mode", 
          "rbx-18mode", "rbx-19mode", "ruby-head", 
          "jruby-head", "1.8.7", "ree"], ".result"=>"configured"}
          end 
    started_at "2012-08-31 23: 33:24"
 
    finished_at "2012-08-31 23: 33:24"
 
    created_at "2012-08-31 23: 33:24"
 
    updated_at "2012-08-31 23: 33:26"
 
    owner_id 7085 
    owner_type "User" 
    event_type "push" 
    comments_url nil 
    base_commit nil 
    head_commit nil 
    result nil 
    message nil
  end

  factory :build do
     number "13" 
     started_at "2012-07-19 13:23:34"
 
     finished_at "2012-07-19 13: 33:34"
     agent nil 
     created_at "2012-07-19 13:23:34" 
     updated_at "2012-07-19 13:24:00" 
     config {{:".result"=>"not_found"} }
     commit_id 511901 
 #    request_id request.id 
     request
     state "finished"
     language nil 
     archived_at nil
     duration 26 
     owner_id 7085
     owner_type "User" 
     result 1 
     previous_result 1 
     event_type "push"
  end

  factory :job do
     config {{ language: "ruby", rvm: "1.9.3", ".result" => "configured"}}
     repository Repository.create!
     #association :repository, factory: :repository
     commit_id 234
     association :source, factory: :build
  end
  factory :job1 do
     allow_failure false
     commit_id 633297
     config {{ language: "ruby", rvm: "1.9.3", ".result" => "configured"}}
     created_at "2012-08-31T23:33:25Z"
     finished_at "2012-08-31T23:33:46Z"
     id 2299590
     #job_id null
     number "28.1"
     owner_id 7085
     owner_type "User"
     queue "builds.common"
     queued_at "2012-08-31T23:33:25Z"
     #repository_id 10389
     result 0
     retries 0
     #source_id #{sid}
     source :build
     source_type "Build"
     started_at "2012-08-31T23:33:26Z"
     state "finished"
     tags ""
     type "Job::Test"
     updated_at "2012-08-31T23:33:47Z"
     worker "ruby2.worker.travis-ci.org:ruby-5" 
  end

end


#  config do
#       { language:"ruby",
#          rvm: "jruby-19mode",
#".result:"=> "configured"}
  #
#
#     config: {language:"ruby", rvm: "1.9.2"}
#.result: "configured"}
#
#config: {language:"ruby"
#rvm: "jruby-18mode"
#.result: "configured"}
#
#
#config: {language:"ruby"
#rvm: "jruby-head"
#.result: "configured"}
#
#
#config: {language:"ruby"
#rvm: "jruby-18mode"
#.result: "configured"}

    