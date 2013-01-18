class VisualBuild < ActiveRecord::Base

  has_many :jobs, class_name: "VisualJob", foreign_key: :build_id
  belongs_to :repository, class_name: "VisualRepository"

  # copied from travis-core/lib/travis/model/build/matrix.rb
  # clearly a workaround
 ENV_KEYS = [:rvm, :gemfile, :env, :otp_release, :php, :node_js, :scala, :jdk, :python, :perl, :compiler, :go].map(&:to_s)

    def self.create_from_json_str(json_str)
      self.create_from_json(JSON.parse(json_str))
    end
    def self.create_from_json(json)
      build = self.new
      build.init_from_json(json)
      build.save
      return build
    end

    def init_from_json(json)
        #:id,
      f = [:result,:number,:started_at,:finished_at,:duration,:build_url,:commit,:branch,:committed_at,:author_name, :committer_name]
      f.each do | field |
        self.send( "#{field}=",json[field.to_s])
      end
      self.travis_id = json["id"]
      self.language=json["config"]["language"]
      self.repository = VisualRepository.get_or_create_from_json(json["repository"])

      self.save

      json["matrix"].each do | json_job|
        job = self.jobs.build
        job.init_from_json(json_job)
        job.save
      end

      return self

    end
end
