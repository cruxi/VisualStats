source 'https://rubygems.org'

gem 'rails', '3.2.9'

gem 'travis-support',  github: 'travis-ci/travis-support'

#this version will only work with migrations in branch database-migrations
#as it is based on a newer db schema version
#gem 'travis-core',     git: 'https://github.com/VisualTravis/travis-core.git'

gem 'travis-core',      git: 'https://github.com/bkleinen/travis-core'

gem 'travis-sidekiqs', github: 'travis-ci/travis-sidekiqs', require: nil

gem 'gh', github: 'rkh/gh'

# database dependency
gem 'sqlite3' , :group => [:development, :test]
gem 'pg', :group => [:test, :production, :devheroku]


group :development, :test do
  gem 'rspec-rails'
end
group :devheroku, :development do
  gem  'activerecord-postgresql-adapter'
end

group :test do 
  gem 'factory_girl_rails'	
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'will_paginate', '~> 3.0'

gem 'd3_rails'

gem 'populator', git: "https://github.com/ryanb/populator.git"
gem 'faker'

gem "htmlentities", "~> 4.3.1"



# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
