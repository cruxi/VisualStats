class RepositoryCompact < ActiveRecord::Base
  attr_accessible :description, :name, :owner_name, :url
end
