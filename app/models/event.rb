class Event < ActiveRecord::Base
  attr_accessible :data, :event, :repository_id, :source_id, :source_type
end
