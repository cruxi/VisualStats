class BuildCompact < ActiveRecord::Base
  attr_accessible :id, :config, :finished_at, :number, :result, :repository_compact_id

  has_many :job_compacts 
  belongs_to :repository_compact, :foreign_key => "repository_compact_id"

  #CLASS METHODS
  def self.getData(firstOpt, secondOpt, amount)
  	data = Array.new

	tempArray = Array.new
	#determine all build_compact_id's as foreign keys in job_compact that belong to a build with jobs with the wanted languages
	tempArray = JobCompact.all(:select => "job_compacts.build_compact_id",:joins => "JOIN job_compacts AS jobs2 ON job_compacts.build_compact_id = jobs2.build_compact_id", :conditions => ["job_compacts.language = '#{firstOpt}' AND jobs2.language='#{secondOpt}'"],:limit => amount, :order => "job_compacts.finished_at")
 	
 	ids = Array.new
 	#put all found id's in an array
 	tempArray.each do |id|
 		ids << id.build_compact_id
 	end

 	#get months names for the period
 	months = getMonthNames(ids)

 	#get jobs for the first and second language
 	firstLang = getJobs(firstOpt, ids)
 	#puts firstLang.to_a
 	secondLang = getJobs(secondOpt, ids)
 	#puts secondLang.to_a

 	#determine the percentage of succeeded builds for each language
 	percentageFirstLang = getPercentageOfSuccess(firstLang,ids)
 	percentageSecondLang = getPercentageOfSuccess(secondLang,ids)


 	data[0] = months
	data[1] = percentageFirstLang
	data[2] = percentageSecondLang
	
	return data
  end


  def self.getMonthNames(ids)
  	monthNumberSet = getMonthNumbers(ids)

 	#translate monthnumbers into words
 	months = Array.new
 	monthNumberSet.each do |num|
 		months << Date::MONTHNAMES[num]
 	end

  	return months
  end	


  def self.getMonthNumbers(ids)
  	#determine the period for comparision
 	tempMonth = JobCompact.where("build_compact_id IN (?)", ids)
 	monthNumberSet = Set.new
 	tempMonth.each do |t| 
 		#determine the monthnumbers
 		monthNumberSet.add(t.finished_at.month)
 	end
 	return monthNumberSet
  end


  def self.getJobs(language, ids)
  	 #determine the jobs for the language
  	 jobs = JobCompact.where("build_compact_id IN (?) AND language='#{language}'", ids)
  	 return jobs
  end


  def self.getPercentageOfSuccess(jobs,ids)
  	perc = Array.new
  	monthNumberSet = getMonthNumbers(ids)
  	monthArray = monthNumberSet.to_a #converts set to array

  	tempSucc = Array.new(monthArray.length, 0) #initialize array entries with 0
  	tempFail = Array.new(monthArray.length, 0) #initialize array entries with 0

	jobs.each do |job|

		curMonth = job.finished_at.month
		counter = 0

		monthArray.each do |monthNumber|
			puts monthNumber
			if (curMonth==monthNumber && job.result==1)
				oldTempSucc = tempSucc[counter]
				tempSucc[counter]= oldTempSucc+1
			end

			if (curMonth==monthNumber && job.result==0)
				oldTempFail = tempFail[counter]
				tempFail[counter]= oldTempFail+1
			end

				oldCounter = counter
				counter = oldCounter+1
		end	

	end

	counter = 0
  	tempSucc.each do |entry|
  		perc << ((entry*100)/(entry+tempFail[counter]))
  		oldCounter = counter
		counter = oldCounter+1
  	end

  	return perc
  end


end
