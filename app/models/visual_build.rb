class VisualBuild < ActiveRecord::Base
  attr_accessible :DateTime, :config, :finished_at, :language, :number, :result, :started_at
end
