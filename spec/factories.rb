require 'factory_girl'

def Factory(*args)
  FactoryGirl.create(*args)
end

FactoryGirl.define do
  factory :build do
    owner { User.first || Factory(:user) }
    repository { Repository.first || Factory(:repository) }
    association :request
    association :commit
    started_at { Time.now.utc }
    finished_at { Time.now.utc }
    number 1
    result 0
  end

  factory :commit do
    commit '62aae5f70ceee39123ef'
    branch 'master'
    message 'the commit message'
    committed_at '2011-11-11T11:11:11Z'
    committer_name 'Sven Fuchs'
    committer_email 'svenfuchs@artweb-design.de'
    author_name 'Sven Fuchs'
    author_email 'svenfuchs@artweb-design.de'
    compare_url 'https://github.com/svenfuchs/minimal/compare/master...develop'
  end

  factory :test, :class => 'Job::Test' do
    owner      { User.first || Factory(:user) }
    repository { Repository.first || Factory(:repository) }
    commit     { Factory(:commit) }
    source     { Factory(:build) }
    log        { Factory(:log) }
    config     { { 'rvm' => '1.8.7', 'gemfile' => 'test/Gemfile.rails-2.3.x' } }
    number     '2.1'
    tags       ""
  end

  factory :log, :class => 'Artifact::Log' do
    content '$ bundle install --pa'
  end

  factory :request do
    repository { Repository.first || Factory(:repository) }
    association :commit
    token 'the-token'
    event_type 'push'
  end

  factory :repository do
    owner { User.find_by_login('svenfuchs') || Factory(:user) }
    name 'minimal'
    owner_name 'svenfuchs'
    owner_email 'svenfuchs@artweb-design.de'
    url { |r| "http://github.com/#{r.owner_name}/#{r.name}" }
    last_duration 60
    created_at { |r| Time.utc(2011, 01, 30, 5, 25) }
    updated_at { |r| r.created_at + 5.minutes }
    last_build_result 0
    last_build_number '2'
    last_build_id 2
    last_build_started_at { Time.now.utc }
    last_build_finished_at { Time.now.utc }
  end

  factory :minimal, :parent => :repository do
  end

  factory :enginex, :parent => :repository do
    name 'enginex'
    owner_name 'josevalim'
    owner_email 'josevalim@email.com'
    owner { User.find_by_login('josevalim') || Factory(:user, :login => 'josevalim') }
    last_duration 30
  end

  factory :event do
    repository { Repository.first || Factory(:repository) }
    source { Build.first || Factory(:build) }
    event 'build:started'
  end

  factory :user do
    name  'Sven Fuchs'
    login 'svenfuchs'
    email 'sven@fuchs.com'
    tokens { [Token.new] }
    github_oauth_token 'github_oauth_token'
  end

  factory :org, :class => 'Organization' do
    name 'travis-ci'
  end

  factory :worker do
    host 'ruby-1.worker.travis-ci.org'
    name 'ruby-1'
    state :created
    last_seen_at { Time.now.utc }
  end

  factory :running_build, :parent => :build do
    repository { Factory(:repository, :name => 'running_build') }
    state :started
  end

  factory :successful_build, :parent => :build do
    repository { |b| Factory(:repository, :name => 'successful_build') }
    result 0
    state :finished
    started_at { Time.now.utc }
    finished_at { Time.now.utc }
  end

  factory :broken_build, :parent => :build do
    repository { Factory(:repository, :name => 'broken_build', :last_build_result => 1) }
    result 1
    state :finished
    started_at { Time.now.utc }
    finished_at { Time.now.utc }
  end

  factory :broken_build_with_tags, :parent => :build do
    repository  { Factory(:repository, :name => 'broken_build_with_tags', :last_build_result => 1) }
    matrix      {[Factory(:test, :tags => "database_missing,rake_not_bundled",   :number => "1.1"),
                  Factory(:test, :tags => "database_missing,log_limit_exceeded", :number => "1.2")]}
    result      1
    previous_result 0
    state       :finished
    started_at  { Time.now.utc }
    finished_at { Time.now.utc }
  end
end

