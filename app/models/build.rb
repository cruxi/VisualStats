class Build 
 attr_accessible :agent, :archived_at, :commit_id, :config, :created_at, :duration, :event_type, :finished_at, :id, :language, :number, :owner_id, :owner_type, :previous_result, :repository_id, :request_id, :result, :started_at, :state, :status, :updated_at

 attr_accessible :repository, :status_message, :result_message, :build_url, :commit, :branch, :message, :compare_url, :committed_at, :author_name, :author_email, :committer_name, :committer_email, :matrix
#
# has_one :commit
# belongs_to :repository, :foreign_key => "repository_id"
# has_many :jobs, :through => :commits


 #Limit the rows to be shown on one page
 self.per_page = 3
end