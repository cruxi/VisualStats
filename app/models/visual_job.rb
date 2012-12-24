class VisualJob < ActiveRecord::Base
  belongs_to :build, class_name: "VisualBuild"
  has_many :dimensions, class_name: "VisualDimension", foreign_key: :job_id
end
