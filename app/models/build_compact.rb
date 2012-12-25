class BuildCompact < ActiveRecord::Base
  attr_accessible :id, :config, :finished_at, :number, :result, :repository_compact_id

  has_many :job_compacts 
  belongs_to :repository_compact, :foreign_key => "repository_compact_id"

end
