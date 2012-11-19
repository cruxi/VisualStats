class Repository < ActiveRecord::Base
  attr_accessible :active, :created_at, :description, :id, :last_build_duration, :last_build_finished_at, :last_build_id, :last_build_language, :last_build_number, :last_build_result, :last_build_started_at, :last_build_status, :last_duration, :name, :owner_email, :owner_id, :owner_name, :owner_type, :private, :updated_at, :url

  has_many :builds
  has_many :events
end
