class JobInfo < ActiveRecord::Base
  attr_accessible :dimension_keys, :integer, :job_id, :language, :repository_id, :result
  has_many :dimensions, dependent: :destroy
end
