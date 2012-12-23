class JobCompact < ActiveRecord::Base
  attr_accessible :allow_failure, :finished_at, :language, :result, :version
end
