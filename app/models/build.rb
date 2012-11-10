class Build < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :repository
  
end
