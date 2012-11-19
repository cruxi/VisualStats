class Build < ActiveRecord::Base
  attr_accessible :agent, :archived_at, :commit_id, :config, :created_at, :duration, :event_type, :finished_at, :id, :language, :number, :owner_id, :owner_type, :previous_result, :repository_id, :request_id, :result, :started_at, :state, :status, :updated_at

  belongs_to :commit
  belongs_to :repository

end
