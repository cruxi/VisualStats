source 'https://rubygems.org'

gem 'rails', '3.2.8'

#gem 'travis-core',    git: 'git://github.com/travis-ci/travis-core', require: 'travis/engine'
#gem 'travis-support', git: 'git://github.com/travis-ci/travis-support'
#gem 'travis-sidekiqs', git: 'git://github.com/travis-ci/travis-sidekiqs'

gem 'travis-support',  github: 'travis-ci/travis-support'
gem 'travis-core',     github: 'travis-ci/travis-core', branch: 'regenerate-repo-key'
gem 'travis-sidekiqs', github: 'travis-ci/travis-sidekiqs', require: nil

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
