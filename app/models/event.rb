class Event 
  attr_accessible :data, :event, :id, :repository_id, :source_id, :source_type

  # belongs_to :repository, :foreign_key => "repository_id"

end
