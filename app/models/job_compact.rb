class JobCompact < ActiveRecord::Base
  attr_accessible :id, :allow_failure, :finished_at, :language, :result, :version, :build_compact_id

  belongs_to :build_compact, :foreign_key => "build_compact_id"
end
