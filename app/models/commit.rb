class Commit 
  attr_accessible :author_email, :author_name, :branch, :commit, :committed_at, :committer_email, :committer_name, :compare_url, :created_at, :message, :ref, :repository_id, :updated_at

 # belongs_to :builds
 # belongs_to :jobs

  #Limit the rows to be shown on one page
  self.per_page = 10

end
