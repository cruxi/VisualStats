class VisualDimension < ActiveRecord::Base

  belongs_to :job, class_name: "VisualJob"

  attr_accessible :key, :value, :visual_job_id

  def self.kv(key,value)
    vd = VisualDimension.new
    vd.key=key.to_s
    vd.value=value.to_s
    vd
  end
  def equalsDimension(other)
     (self.key == other.key) && (self.value == other.value)
  end
end
