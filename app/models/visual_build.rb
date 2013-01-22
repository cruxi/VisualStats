#include VisualBuildMigrationHelper
#require 'active_record_extensions'
class VisualBuild < ActiveRecord::Base

  #Limit the rows to be shown on one page
  self.per_page = 10
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
    def self.build_from_json_str(json_str)
      self.build_from_json(JSON.parse(json_str))
    end
    def self.create_from_json(json)
      build = build_from_json(json)
      build.save
      repository = build.repository
      repository.save
      build
    end
    def self.build_from_json(json)
      build = self.new
      build.init_from_json(json)
      build
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
      self.repository = VisualRepository.get_or_create_from_json(self,json["repository"])

      #self.save

      json["matrix"].each do | json_job|
        job = self.jobs.build
        job.init_from_json(json_job)
        #job.save
      end

      return self

    end


    #CLASS METHODS

  def self.getJobs(lang1, lang2, amount)
  myData = Array.new

  tempArray = Array.new
  #determine all build_compact_id's as foreign keys in job_compact that belong to a build with jobs with the wanted languages
 # tempArray = VisualJob.where("visual_jobs.language ='#{lang1}' OR visual_jobs.language='#{lang2}'").limit(amount).order(:finished_at)
  #VisualJob.all(:select => "DISTINCT visual_jobs.id, visual_jobs.finished_at, visual_jobs.result, visual_jobs.language",:joins => "JOIN visual_jobs AS jobs2 ON visual_jobs.build_id = jobs2.build_id", :conditions => ["visual_jobs.language = '#{lang1}' AND jobs2.language='#{lang2}'"], :limit => amount, :order => "visual_jobs.finished_at")
  
  jobsLang1 = VisualJob.where("visual_jobs.language ='#{lang1}'").order(:finished_at)
  jobsLang2 = VisualJob.where("visual_jobs.language='#{lang2}'").order(:finished_at)

  # tempArray.each do |job|
  #     curLang = job.language
  #     puts "test"
  #     puts job.language
  #     if (curLang==lang1) 
  #         jobsLang1 << job
  #     else 
  #         jobsLang2 << job
  #     end
  # end

  ##FIRST LANG
  myData[0] = Hash.new 
  entry1 = myData[0]
  entry1['name'] = lang1

  tempXlang1 = Array.new
  tempYlang1 = Array.new
  jobsLang1.each do |lang1|
    tempYlang1 << lang1.result
    tempXlang1 << lang1.finished_at
  end
  entry1['x'] = tempXlang1
  entry1['y'] = tempYlang1

  ##SECOND LANG
  myData[1] = Hash.new 
  entry2 = myData[1]
  entry2['name'] = lang2

  tempXlang2 = Array.new
  tempYlang2 = Array.new
  jobsLang2.each do |lang2|
    tempYlang2 << lang2.result
    tempXlang2 << lang2.finished_at
  end
  entry2['x'] = tempXlang2
  entry2['y'] = tempYlang2


  return myData
end


    def self.create_from_build(build)
      visual_build = self.new
      visual_build.init_from_build(build)
      visual_build.save
      return visual_build
    end

    def self.webhook_json(build)
      Travis::Api.data(build, :for => 'webhook', :type => 'build/finished', :version => 'v1')
    end

    def self.create_from_build_via_json(build)
      json = VisualBuild.webhook_json(build)
      vb = VisualBuild.create_from_json(json)
      VisualBuild.cross_check(vb,build)
      vb
    end

    def self.cross_check(visual_build,build,message ="")
      ok = true
      s = build.matrix.size
      unless s == visual_build.jobs.size
        build.logger.warn("matrix size unequal #{build.id} / #{message}")
        ok = false
      end
      unless s == 0
        unless (l1 = build.matrix.first.config[:language]) == (l2 = visual_build.jobs.first.language)
          build.logger.warn("languages unequal #{build.id} / #{message} / #{l1} / #{l2}")
          ok = false
        end
      end
      return ok
    end

end

# helper methods for double checking

class ActiveRecord::Base
  def equal_values(other)
    (attributes.keys - ["id","created_at","updated_at"]).each do |attr|
     unless self.send(attr).activerecord_equality( other.send(attr))
       puts "====#{self.class} #{self.id} ==== missmatch #{attr} #{self.send(attr)} <=> #{other.send(attr)}  (#{self.send(attr).class}) (#{other.send(attr).class})"
       return false
     end
    end
    return true
   end
   def diff_attributes(other,ignore =[])
    result = []
    (attributes.keys - ["id","created_at","updated_at"]- ignore).each do |attr|
     unless self.send(attr).activerecord_equality( other.send(attr))
       result << "====#{self.class} #{self.id} ==== missmatch #{attr} #{self.send(attr)} <=> #{other.send(attr)}  (#{self.send(attr).class}) (#{other.send(attr).class})"
     end
    end
    result
   end
end

class Object
  def activerecord_equality(other_object)
    self == other_object
  end
end
class ActiveSupport::TimeWithZone
  #2012-09-23T15:35:31Z <=> 2012-09-23 15:35:31 UTC
  def activerecord_equality(other_object)
    if (other_object.class == String)
      return self == Time.zone.parse(other_object)
    else
      return self.to_i == other_object.to_i
    end
  end
end
class String
  def activerecord_equality(other_object)
    return self == other_object unless other_object.class == ActiveSupport::TimeWithZone
    Time.zone.parse(self) == other_object
  end
end

