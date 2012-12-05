class Job < ActiveRecord::Base
  attr_accessible :allow_failure, :commit_id, :config, :created_at, :finished_at, :id, :job_id, :number, :owner_id, :owner_type, :queue, :queued_at, :repository_id, :result, :retries, :source_id, :source_type, :started_at, :state, :status, :tags, :type, :updated_at, :worker

  belongs_to :repository, :foreign_key => "repository_id"


  # the known versions of **some** of the runtimes.
  KNOWN_RUBY_VERSIONS   = %w(1.8.7 ruby-1.8.7 1.9.2 ruby-1.9.2 1.9.3 ruby-1.9.3 ruby-head jruby jruby-18mode jruby-19mode rbx rbx-18mode rbx-19mode jruby-head ree ree-1.8.7)
  KNOWN_NODE_VERSIONS   = %w(0.6 0.8 0.9)
  KNOWN_PHP_VERSIONS    = %w(5.2 5.3 5.3.2 5.3.8 5.4)
  KNOWN_PYTHON_VERSIONS = %w(2.5 2.6 2.7 3.2)
  KNOWN_PERL_VERSIONS   = %w(5.10 5.12 5.14 5.16)

  @KNOWN_LANGUAGES = %w(ruby java python)


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



  # this is used to retrieve the objects config file
  # If no value has been set for the language field, we assume ruby as the language.
  def parsecfg

    yaml = YAML.load(config)

    begin
      language = yaml.fetch(:language)
      runtime = yaml.keys[1]
      version = yaml.values[1]
    rescue
      language = "ruby"
      pp "Assigned: #{language}"
    ensure
      pp "Language is: #{language}"
      pp "Version is: #{version}"
    end
  end

  # this is used to retrieve the objects config file
  # If no value has been set for the language field, we assume ruby as the language.
  def parsecfg2

    yaml = YAML.load(config)

    # !Nicht vergessen values sind hier immer strings!
    begin
      # p "yaml.keys[0]: #{yaml.keys[0]}"
      # p "yaml.values[0]: #{yaml.values[0]}"
      # p "yaml.keys[1]: #{yaml.keys[1]}"
      # p "yaml.values[1]: #{yaml.values[1]}"
       
      # Checking via intersection whether we have a matching key or value
      #lkey   = [yaml.keys[0]] & [:language]
      #lvalue = [yaml.values[0]] & ['python', 'ruby']

      lkey   = [yaml.keys[0]] 
      lvalue = [yaml.values[0]] 
      rkey   = [yaml.keys[1]] 
      rvalue = [yaml.values[1]]
      vkey   = [yaml.keys[2]] 
      vvalue = [yaml.values[2]]

   

      pp "language key: #{lkey}"
      pp "language value: #{lvalue}"

      pp "runtime key: #{rkey}"
      pp "runtime value: #{rvalue}"

      pp "version key: #{vkey}"
      pp "version value: #{vvalue}"

      
      p "-------------------------------"
    

      #runtime = [yaml.keys[1]] & [:rvm:, :ruby:]
      #p "Runtime: #{runtime}"
      #p version = [yaml.values[1]] & KNOWN_VERSIONS
      #language = yaml.fetch(:language)
      #runtime = yaml.keys[1]
      #version = yaml.values[1]

      # rescue
      #   language = "ruby"
      #   pp "Assigned: #{language}"
      # ensure
      #   pp "Language is: #{language}"
      #   #pp "Version is: #{version}"
      # end
    end
  end

  def prnts
    cfg = YAML.load(config)
    pp "Language: #{cfg.values[0]} Runtime: #{cfg.keys[1]} Version: #{cfg.values[1]}"
  end


  #Limit the rows to be shown on one page
  self.per_page = 10

end