class VisualRepository < ActiveRecord::Base
  attr_accessible :name, :owner_name, :url
end
