class BuildCompact < ActiveRecord::Base
  attr_accessible :id, :config, :finished_at, :number, :result, :repository_compact_id

  has_many :job_compacts 
  belongs_to :repository_compact, :foreign_key => "repository_compact_id"


  #CLASS METHODS

  def self.getJobs(lang1, lang2, amount)
  data = Array.new

  tempArray = Array.new
  #determine all build_compact_id's as foreign keys in job_compact that belong to a build with jobs with the wanted languages
 # tempArray = VisualJob.where("visual_jobs.language ='#{lang1}' OR visual_jobs.language='#{lang2}'").limit(amount).order(:finished_at)
  #VisualJob.all(:select => "DISTINCT visual_jobs.id, visual_jobs.finished_at, visual_jobs.result, visual_jobs.language",:joins => "JOIN visual_jobs AS jobs2 ON visual_jobs.build_id = jobs2.build_id", :conditions => ["visual_jobs.language = '#{lang1}' AND jobs2.language='#{lang2}'"], :limit => amount, :order => "visual_jobs.finished_at")
  
  jobsLang1 = VisualJob.where("visual_jobs.language ='#{lang1}'").limit(amount).order(:finished_at)
  jobsLang2 = VisualJob.where("visual_jobs.language='#{lang2}'").limit(amount).order(:finished_at)

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
  data[0] = Hash.new 
  entry1 = data[0]
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
  data[1] = Hash.new 
  entry2 = data[1]
  entry2['name'] = lang2

  tempXlang2 = Array.new
  tempYlang2 = Array.new
  jobsLang2.each do |lang2|
    tempYlang2 << lang2.result
    tempXlang2 << lang2.finished_at
  end
  entry2['x'] = tempXlang2
  entry2['y'] = tempYlang2


 puts data
  end



 #  def self.getData(firstOpt, secondOpt, amount)
 #  data = Array.new

	# tempArray = Array.new
	# #determine all build_compact_id's as foreign keys in job_compact that belong to a build with jobs with the wanted languages
	# tempArray = JobCompact.all(:select => "job_compacts.build_compact_id",:joins => "JOIN job_compacts AS jobs2 ON job_compacts.build_compact_id = jobs2.build_compact_id", :conditions => ["job_compacts.language = '#{firstOpt}' AND jobs2.language='#{secondOpt}'"],:limit => amount, :order => "job_compacts.finished_at")
 	
 # 	ids = Array.new
 # 	#put all found id's in an array
 # 	tempArray.each do |id|
 # 		ids << id.build_compact_id
 # 	end

 # 	#get months names for the period
 # 	months = getMonthNames(ids)

 # 	#get jobs for the first and second language
 # 	firstLang = getJobs(firstOpt, ids)
 # 	#puts firstLang.to_a
 # 	secondLang = getJobs(secondOpt, ids)
 # 	#puts secondLang.to_a

 # 	#determine the percentage of succeeded builds for each language
 # 	percentageFirstLang = getPercentageOfSuccess(firstLang,ids)
 # 	percentageSecondLang = getPercentageOfSuccess(secondLang,ids)


 # 	data[0] = months
	# data[1] = percentageFirstLang
	# data[2] = percentageSecondLang
	
	# return data
 #  end


 #  def self.getMonthNames(ids)
  
 #  monthNumberSet = getMonthNumbers(ids)

 # 	#translate monthnumbers into words
 # 	months = Array.new
 # 	monthNumberSet.each do |num|
 # 		months << Date::MONTHNAMES[num]
 # 	end

 #  	return months
 #  end	


 #  def self.getMonthNumbers(ids)
 #  	#determine the period for comparision
 # 	tempMonth = JobCompact.where("build_compact_id IN (?)", ids)
 # 	monthNumberSet = Set.new
 # 	tempMonth.each do |t| 
 # 		#determine the monthnumbers
 # 		monthNumberSet.add(t.finished_at.month)
 # 	end
 # 	return monthNumberSet
 #  end


 #  def self.getJobs(language, ids)
 #  	 #determine the jobs for the language
 #  	 jobs = JobCompact.where("build_compact_id IN (?) AND language='#{language}'", ids)
 #  	 return jobs
 #  end


 #  def self.getPercentageOfSuccess(jobs,ids)
 #  	perc = Array.new
 #  	monthNumberSet = getMonthNumbers(ids)
 #  	monthArray = monthNumberSet.to_a #converts set to array

 #  	tempSucc = Array.new(monthArray.length, 0) #initialize array entries with 0
 #  	tempFail = Array.new(monthArray.length, 0) #initialize array entries with 0

	# jobs.each do |job|

	# 	curMonth = job.finished_at.month
	# 	counter = 0

	# 	monthArray.each do |monthNumber|
	# 		puts monthNumber
	# 		if (curMonth==monthNumber && job.result==1)
	# 			oldTempSucc = tempSucc[counter]
	# 			tempSucc[counter]= oldTempSucc+1
	# 		end

	# 		if (curMonth==monthNumber && job.result==0)
	# 			oldTempFail = tempFail[counter]
	# 			tempFail[counter]= oldTempFail+1
	# 		end

	# 			oldCounter = counter
	# 			counter = oldCounter+1
	# 	end	

	# end

	# counter = 0
 #  	tempSucc.each do |entry|
 #  		perc << ((entry*100)/(entry+tempFail[counter]))
 #  		oldCounter = counter
	# 	counter = oldCounter+1
 #  	end

 #  	return perc
 #  end


end
