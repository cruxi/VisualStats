include VisualBuildMigrationHelper
require 'set'
class VisualBuild < ActiveRecord::Base


  has_many :jobs, class_name: "VisualJob", foreign_key: :build_id, dependent: :destroy
  belongs_to :repository, class_name: "VisualRepository"

  # copied from travis-core/lib/travis/model/build/matrix.rb
  # clearly a workaround
  ENV_KEYS = [:rvm, :gemfile, :env, :otp_release, :php, :node_js, :scala, :jdk, :python, :perl, :compiler, :go].map(&:to_s)





    def same_matrix(other)
      return false unless self.jobs.size == other.jobs.size
      return false unless self.jobs.first.dimensions.size == other.jobs.first.dimensions.size
      return true
    end

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
      #f = [:result,:number,:started_at,:finished_at,:duration,:build_url,:commit,:branch,:committed_at,:author_name, :committer_name]
      #f.each do | field |
      #  self.send( "#{field}=",json[field.to_s])
      #end
      #all.map { |n| f = n.to_s;  "  #{f}=json['#{f}']" }.each {|l| puts l}
      # bringt keinerlei performancegewinn :(
      self.result=json['result']
      self.number=json['number']
      self.started_at=json['started_at']
      self.finished_at=json['finished_at']
      self.duration=json['duration']
      self.build_url=json['build_url']
      self.commit=json['commit']
      self.branch=json['branch']
      self.committed_at=json['committed_at']
      self.author_name=json['author_name']
      self.committer_name=json['committer_name']
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


    def self.create_from_build(build)
      visual_build = self.new
      visual_build.init_from_build(build)
      visual_build.save
      return visual_build
    end

    def init_from_build(build)
      self.result=build.result
      self.number=build.number
      self.started_at=build.started_at
      self.finished_at=build.finished_at
      self.duration=build.duration
      self.build_url=build.repository.url.gsub(/github\.com/,"travis-ci.org")+"/builds/#{build.id}"
      self.commit=build.commit.commit
      self.branch=build.commit.branch
      self.committed_at=build.commit.committed_at
      self.author_name=build.commit.author_name
      self.committer_name=build.commit.committer_name
      self.travis_id = build.id
      self.language = build.config[:language]
      #self.language= build.matrix.first.config[:language] # || "ruby"
     # self.language=build.config["language"] #|| "ruby"
      self.repository = VisualRepository.get_or_create_from_repository(build.repository)

      self.save

      build.matrix.each do | j|
        job = self.jobs.build
        job.init_from_job(j)
        job.save
      end

      return self

    end
end
