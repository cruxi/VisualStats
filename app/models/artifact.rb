class Artifact
  attr_accessible :content, :id, :job_id

  #  is this still needed?
  self.inheritance_column = "ruby_type"
 # set_inheritance_column :ruby_type
end
