class Build < ActiveRecord::Base
  attr_accessible :agent, :archived_at, :commit_id, :config, :created_at, :duration, :event_type, :finished_at, :id, :language, :number, :owner_id, :owner_type, :previous_result, :repository_id, :request_id, :result, :started_at, :state, :status, :updated_at

  has_one :commit
  belongs_to :repository, :foreign_key => "repository_id"

  #Limit the rows to be shown on one page
  self.per_page = 100

end
