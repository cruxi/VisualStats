class MigrationError < ActiveRecord::Base
  attr_accessible :message, :stacktrace, :travis_id
end
