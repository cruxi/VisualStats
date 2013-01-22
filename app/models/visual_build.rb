class VisualBuild < ActiveRecord::Base
  #Limit the rows to be shown on one page
  self.per_page = 10
  
  has_many :jobs, class_name: "VisualJob", foreign_key: :build_id
  belongs_to :repository, class_name: "VisualRepository"

  # copied from travis-core/lib/travis/model/build/matrix.rb
  # clearly a workaround
 ENV_KEYS = [:rvm, :gemfile, :env, :otp_release, :php, :node_js, :scala, :jdk, :python, :perl, :compiler, :go].map(&:to_s)

    def self.create_from_json(json_str)
      build = self.new
      #json_str is already json object and not a string
      #json = JSON.parse(json_str) 
      json = json_str
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



end
