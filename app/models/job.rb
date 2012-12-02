class Job < ActiveRecord::Base
  attr_accessible :allow_failure, :commit_id, :config, :created_at, :finished_at, :id, :job_id, :number, :owner_id, :owner_type, :queue, :queued_at, :repository_id, :result, :retries, :source_id, :source_type, :started_at, :state, :status, :tags, :type, :updated_at, :worker

  belongs_to :repository, :foreign_key => "repository_id"

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


  # this is used to retrieve the respective models config file
  def parsecfg

    yaml = YAML.load(config)
    #pp yaml
    
    language = yaml.fetch(:language)
    version = yaml.values[1] # we cannot look for the hash key here, since it is sometimes present and sometimes not. Position of the key should stay the same though

    pp "Language: #{language}"
    pp "Version:  #{version}"

  end
  
  #Limit the rows to be shown on one page
  self.per_page = 10

end
