class VisualRepository < ActiveRecord::Base

  attr_accessible :name, :owner_name, :url

  has_many :builds, class_name: "VisualBuild", foreign_key: :repository_id
end
