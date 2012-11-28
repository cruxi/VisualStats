class Job < ActiveRecord::Base
  attr_accessible :allow_failure, :commit_id, :config, :created_at, :finished_at, :id, :job_id, :number, :owner_id, :owner_type, :queue, :queued_at, :repository_id, :result, :retries, :source_id, :source_type, :started_at, :state, :status, :tags, :type, :updated_at, :worker


# workaround since :type is a reserved keyword by ActiveRecord::Base. 
# Please see http://www.ruby-forum.com/topic/101557 for further details.
  set_inheritance_column :ruby_type

  # getter for the "type" column
  def device_type
    self[:type]
  end

  # setter for the "type" column
  def device_type=(s)
    self[:type] = s
  end

end
