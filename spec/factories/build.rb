require 'factory_girl'

FactoryGirl.define do
#http://robots.thoughtbot.com/post/254496652/aint-no-calla-back-girl

  factory :build_with_matrix, class: Build do

    #request_id 742453
   # association :repository, factory: :repository_with_matrix
    association :request, factory: :request_with_matrix #, repository: {repository}
    repository {request.repository}
    #commit_id 704989
    association :commit, factory: :commit_with_matrix
    #  repository_id 11194

    number "52"
    status nil
    started_at "2012-09-23 15:36:04"
    finished_at "2012-09-23 15:37:08"
    agent nil
    created_at "2012-09-23 15:36:02"
    updated_at "2012-09-23 15:37:15"
  #  config {:language=>"ruby", :rvm=>["1.8.7", "1.9.2", "1.9.3"], :".result"=>"configured"}
    config {}
    state "finished"
    language nil
    archived_at nil
    duration 170
    owner_id 8
    owner_type "User"
    result 0
    previous_result 0
    event_type "push"
  end
  factory :repository_with_matrix, class: Repository do
    name "rails-i18n"
    url "https://github.com/svenfuchs/rails-i18n"
    last_duration nil
    created_at "2012-03-30 09:53:22"
    updated_at "2012-10-23 22:58:36"
    last_build_id 2906914
    last_build_number "67"
    last_build_status 0
    last_build_started_at "2012-10-23 22:56:33"
    last_build_finished_at "2012-10-23 22:58:26"
    owner_name "svenfuchs"
    owner_email nil
    active true
    description "Repository for collecting Locale data for Ruby on R..."
    last_build_language nil
    last_build_duration 294
    private false
    owner_id 8
    owner_type "User"
    last_build_result 0
  end
  factory :request_with_matrix, class: Request do
    association :repository, factory: :repository_with_matrix
    association :commit, factory: :commit_with_matrix
    # repository_id 11194
    #commit_id 704989
    state "started"
    source nil
   # payload {"pusher"=>{"name"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}, "repository"=>{"name"=>"rails-i18n", "size"=>260, "has_wiki"=>true, "created_at"=>"2008-07-31T06:07:53-07:00", "private"=>false, "watchers"=>1501, "url"=>"https://github.com/svenfuchs/rails-i18n", "fork"=>false, "language"=>"Ruby", "pushed_at"=>"2012-09-23T08:35:57-07:00", "id"=>38867, "open_issues"=>6, "has_downloads"=>true, "has_issues"=>true, "homepage"=>"http://rails-i18n.org", "description"=>"Repository for collecting Locale data for Ruby on Rails I18n as well as other interesting, Rails related I18n stuff", "stargazers"=>1501, "forks"=>475, "owner"=>{"name"=>"svenfuchs", "email"=>"me@svenfuchs.com"}}, "forced"=>false, "head_commit"=>{"modified"=>["rails/locale/ar.yml", "rails/locale/cs.yml", "rails/locale/cy.yml", "rails/locale/lo.yml", "rails/locale/lt.yml", "rails/locale/lv.yml", "rails/locale/pl.yml", "rails/locale/rm.yml", "rails/locale/ro.yml", "rails/locale/sl.yml", "rails/locale/sr.yml"], "added"=>[], "timestamp"=>"2012-09-23T08:35:31-07:00", "removed"=>[], "author"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/aafe7be36248a960e69803b53dfe8a234ca1dfed", "id"=>"aafe7be36248a960e69803b53dfe8a234ca1dfed", "distinct"=>true, "message"=>"Add missing pluralization keys\n\nThis modifications are necessary to pass tests\nagainst the i18n-rails 0.3.0.", "committer"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}}, "after"=>"aafe7be36248a960e69803b53dfe8a234ca1dfed", "deleted"=>false, "commits"=>[{"modified"=>[], "added"=>[], "timestamp"=>"2012-09-17T15:19:35-07:00", "removed"=>["rails/locale/gsw-CH.yml"], "author"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/bfdf1d4b24d18d8c0a74b14d22a6f7d9824c27e0", "id"=>"bfdf1d4b24d18d8c0a74b14d22a6f7d9824c27e0", "distinct"=>true, "message"=>"Remove :gsw-CH since we already have :de-CH", "committer"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}}, {"modified"=>[], "added"=>[], "timestamp"=>"2012-09-17T16:06:26-07:00", "removed"=>["rails/locale/en-US.yml"], "author"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/32aca4b840a322137da66d57daa32815bb7cc1fb", "id"=>"32aca4b840a322137da66d57daa32815bb7cc1fb", "distinct"=>true, "message"=>"Remove en-US.yml as it identical to en.yml (and always will be since this is the default).", "committer"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}}, {"modified"=>[], "added"=>["rails/locale/bn.yml", "rails/locale/gl.yml", "rails/locale/pt.yml", "rails/locale/sv.yml"], "timestamp"=>"2012-09-17T16:08:20-07:00", "removed"=>["rails/locale/bn-IN.yml", "rails/locale/gl-ES.yml", "rails/locale/pt-PT.yml", "rails/locale/sv-SE.yml"], "author"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/9df832e4b97c486347ab8571604065499c6a2c3c", "id"=>"9df832e4b97c486347ab8571604065499c6a2c3c", "distinct"=>true, "message"=>"Remove the region code from locales where possible\n\nSince fallbacks often just pop segments off the end, a less specific locale code potentially means more matches.\n\nNot knowledgeable enough to apply this to :zh", "committer"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}}, {"modified"=>[], "added"=>["rails/locale/iso-639-2/csb.yml", "rails/locale/iso-639-2/dsb.yml", "rails/locale/iso-639-2/fur.yml", "rails/locale/iso-639-2/hsb.yml", "rails/locale/iso-639-2/scr.yml"], "timestamp"=>"2012-09-17T16:18:26-07:00", "removed"=>["rails/locale/csb.yml", "rails/locale/dsb.yml", "rails/locale/fur.yml", "rails/locale/hsb.yml", "rails/locale/sr-Latn.yml"], "author"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/4fb32b918c0e227c5783cb4bc11642a6d4cae20e", "id"=>"4fb32b918c0e227c5783cb4bc11642a6d4cae20e", "distinct"=>true, "message"=>"Move iso-639-2 locales into their own directory (and out of the spec path)\n\nNot sure sr-Latin => scr, but it was pissing me off!", "committer"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}}, {"modified"=>["spec/unit/translation_spec.rb"], "added"=>[], "timestamp"=>"2012-09-18T01:58:19-07:00", "removed"=>[], "author"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/065da9c66a54bcb5e52f473a244321fff3c61344", "id"=>"065da9c66a54bcb5e52f473a244321fff3c61344", "distinct"=>true, "message"=>"Specs compare translations files to :en and not :en-US", "committer"=>{"name"=>"Christopher Dell", "username"=>"tigrish", "email"=>"chris@tigrish.com"}}, {"modified"=>["rails-i18n.gemspec"], "added"=>[], "timestamp"=>"2012-09-23T07:13:54-07:00", "removed"=>[], "author"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/ea94b8ba9c01be07ceea6f5d77d642603f6f235c", "id"=>"ea94b8ba9c01be07ceea6f5d77d642603f6f235c", "distinct"=>true, "message"=>"Update development dependencies", "committer"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}}, {"modified"=>["spec/unit/translation_spec.rb"], "added"=>["rails/locale/bn.yml", "rails/locale/gl.yml", "rails/locale/iso-639-2/csb.yml", "rails/locale/iso-639-2/dsb.yml", "rails/locale/iso-639-2/fur.yml", "rails/locale/iso-639-2/hsb.yml", "rails/locale/iso-639-2/scr.yml", "rails/locale/pt.yml", "rails/locale/sv.yml"], "timestamp"=>"2012-09-23T07:52:16-07:00", "removed"=>["rails/locale/bn-IN.yml", "rails/locale/en-US.yml", "rails/locale/gl-ES.yml", "rails/locale/gsw-CH.yml", "rails/locale/csb.yml", "rails/locale/dsb.yml", "rails/locale/fur.yml", "rails/locale/hsb.yml", "rails/locale/sr-Latn.yml", "rails/locale/pt-PT.yml", "rails/locale/sv-SE.yml"], "author"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/fda4f08e75e9055439cebba44e9c07559975fd91", "id"=>"fda4f08e75e9055439cebba44e9c07559975fd91", "distinct"=>true, "message"=>"Merge remote-tracking branch 'tigrish/iso_639_1_locales'", "committer"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}}, {"modified"=>[], "added"=>["rails/pluralization/hsb.rb"], "timestamp"=>"2012-09-23T08:06:46-07:00", "removed"=>[], "author"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/46c525aafd5f07925e12af1fc3e99cae86859d2f", "id"=>"46c525aafd5f07925e12af1fc3e99cae86859d2f", "distinct"=>true, "message"=>"Add pluralization rule for Upper Sorbian", "committer"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}}, {"modified"=>["rails/locale/ar.yml", "rails/locale/cs.yml", "rails/locale/cy.yml", "rails/locale/lo.yml", "rails/locale/lt.yml", "rails/locale/lv.yml", "rails/locale/pl.yml", "rails/locale/rm.yml", "rails/locale/ro.yml", "rails/locale/sl.yml", "rails/locale/sr.yml"], "added"=>[], "timestamp"=>"2012-09-23T08:35:31-07:00", "removed"=>[], "author"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}, "url"=>"https://github.com/svenfuchs/rails-i18n/commit/aafe7be36248a960e69803b53dfe8a234ca1dfed", "id"=>"aafe7be36248a960e69803b53dfe8a234ca1dfed", "distinct"=>true, "message"=>"Add missing pluralization keys\n\nThis modifications are necessary to pass tests\nagainst the i18n-rails 0.3.0.", "committer"=>{"name"=>"Tsutomu Kuroda", "username"=>"kuroda", "email"=>"t-kuroda@oiax.jp"}}], "ref"=>"refs/heads/master", "compare"=>"https://github.com/svenfuchs/rails-i18n/compare/f756fd46c5cd...aafe7be36248", "before"=>"f756fd46c5cd0963ac4effcee67313f2913ea50b", "created"=>false}
    payload {}
    token nil
  #  config {"language"=>"ruby",     "rvm"=>["1.8.7",     "1.9.2",     "1.9.3"],     ".result"=>"configured"}
    config {}
    started_at "2012-09-23 15:36:01"
    finished_at "2012-09-23 15:36:01"
    created_at "2012-09-23 15:36:01"
    updated_at "2012-09-23 15:36:02"
    owner_id 8
    owner_type "User"
    event_type "push"
    comments_url nil
    base_commit nil
    head_commit nil
    result nil
    message nil
  end

  factory :commit_with_matrix, class: Commit do
     #repository_id 11194
    commit "aafe7be36248a960e69803b53dfe8a234ca1dfed"
    ref "refs/heads/master"
    branch "master"
    message "Add missing pluralization keys\n\nThis modifications ..."
    compare_url "https://github.com/svenfuchs/rails-i18n/compare/f75..."
    committed_at "2012-09-23 15:35:31"
    committer_name "Tsutomu Kuroda"
    committer_email "t-kuroda@oiax.jp"
    author_name "Tsutomu Kuroda"
    author_email "t-kuroda@oiax.jp"
    created_at "2012-09-23 15:36:01"
    updated_at "2012-09-23 15:36:01"
  end



  factory :job1, class: Job do
    #repository_id 11194
    #commit_id 704989
    #source_id 2537773
    source_type "Build"
    queue "builds.common"
    type "Job::Test"
    state "finished"
    number "52.1"
    config {{:language => "ruby", :rvm=>"1.8.7", :".result"=>"configured"}}
    status nil
    job_id nil
    worker "ruby4.worker.travis-ci.org:ruby-2"
    started_at "2012-09-23 15:36:04"
    finished_at "2012-09-23 15:36:50"
    created_at "2012-09-23 15 :36:02"
    updated_at "2012-09-23 15:36:56"
    tags ""
    retries 0
    allow_failure false
    owner_id 8
    owner_type "User"
    result 0
    queued_at "2012-09-23 15:36:04"
  end
end

