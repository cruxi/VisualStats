class Artifact < ActiveRecord::Base
  attr_accessible :content, :id, :job_id

   set_inheritance_column :ruby_type

end
