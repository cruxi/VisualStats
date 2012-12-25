class RepositoryCompact < ActiveRecord::Base
  attr_accessible :id, :description, :name, :owner_name, :url

  has_many :build_compacts
end
