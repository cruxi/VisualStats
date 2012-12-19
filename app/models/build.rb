class Build 
 attr_accessible :agent, :archived_at, :commit_id, :config, :created_at, :duration, :event_type, :finished_at, :id, :language, :number, :owner_id, :owner_type, :previous_result, :repository_id, :request_id, :result, :started_at, :state, :status, :updated_at

 attr_accessible :repository, :status_message, :result_message, :build_url, :commit, :branch, :message, :compare_url, :committed_at, :author_name, :author_email, :committer_name, :committer_email, :matrix
#
# has_one :commit
# belongs_to :repository, :foreign_key => "repository_id"
# has_many :jobs, :through => :commits


 #Limit the rows to be shown on one page
 self.per_page = 3

# CLASS METHODS
def self.getFailedAmount
	failedAmount = Build.where("result = ?", 0).count(:result)
	return failedAmount
end

def self.getSuccessAmount
	successAmount = Build.where("result = ?", 1).count(:result)
	return successAmount
end

def self.getNotFinishedAmount
	notFinishedAmount = Build.where("duration < 1").count(:result)
	return notFinishedAmount
end

def self.getLanguagesAmount
	amount = Hash.new 
	s = Build::ENV_KEYS

 	s.each { |lang| 
 		tempLangAmount = Build.where("config like ?","%#{lang}%").count() 
 		amount[lang]=tempLangAmount
 	}

 	return amount
end

def self.getLanguges 
	s = Build::ENV_KEYS
	languages = Array.new

	s.each { |lang| 
		languages << lang.to_s
	}
	return languages
end	



#INSTANCE METHODS


end