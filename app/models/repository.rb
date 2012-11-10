class Repository < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :builds
  
end
