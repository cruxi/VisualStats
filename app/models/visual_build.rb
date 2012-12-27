class VisualBuild < ActiveRecord::Base

  has_many :jobs, class_name: "VisualJob", foreign_key: :build_id
  belongs_to :repository, class_name: "VisualRepository"

  # copied from travis-core/lib/travis/model/build/matrix.rb
  # clearly a workaround
 ENV_KEYS = [:rvm, :gemfile, :env, :otp_release, :php, :node_js, :scala, :jdk, :python, :perl, :compiler, :go].map(&:to_s)

    def self.create_from_json(json_str)
      build = self.new
      build.init_from_json(json_str)
      build.save
      return build
    end

    def init_from_json(json_str)
      json = JSON.parse(json_str)
      #:id,
      f = [:result,:number,:started_at,:finished_at,:duration,:build_url,:commit,:branch,:committed_at,:author_name, :committer_name]
      f.each do | field |
        self.send( "#{field}=",json[field.to_s])
      end
      self.language=json["config"]["language"]
      self.save

      json["matrix"].each do | json_job|
        job = self.jobs.build
        job.init_from_json(json_job)
        job.save
      end
      return self
    end
end
