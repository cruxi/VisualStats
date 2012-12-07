class Artifact 
  attr_accessible :content, :id, :job_id
 
  #  is this still needed?
  set_inheritance_column :ruby_type
end