class Dimension < ActiveRecord::Base
  attr_accessible :job_info_id, :key, :value
  belongs_to :job_info
end
