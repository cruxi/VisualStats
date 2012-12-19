class Repository 
   attr_accessible :active, :created_at, :description, :id, :last_build_duration, :last_build_finished_at, :last_build_id, :last_build_language, :last_build_number, :last_build_result, :last_build_started_at, :last_build_status, :last_duration, :name, :owner_email, :owner_id, :owner_name, :owner_type, :private, :updated_at, :url

#  has_many :builds
#  has_many :events

  #Limit the rows to be shown on one page
  self.per_page = 10




def getPercentForBuilds 
	builds = self.builds
	months = []
	statistic = Hash.new
	monthAmount = Array.new(12, Hash.new { |hash, key| hash[key] = 0})

	builds.each do |build|
		
		if (build.finished_at!=nil) 
			monthNumber = build.finished_at.month
			buildResult = build.result
			tempHash = Hash.new { |hash, key| hash[key] = 0}

			#months << Date::MONTHNAMES[monthNumber]

			curHash = monthAmount[monthNumber-1]

			if (buildResult==1) 
				tempHash["success"] = curHash["success"]+1
				tempHash["fail"] = curHash["fail"]
			end 

			if (buildResult==0) 
				tempHash["fail"] = curHash["fail"]+1
				tempHash["success"] = curHash["success"]
			end 

			monthAmount[monthNumber-1] = tempHash
		end


	end

	#convert hash with amount of fail and success builds per month to percentage
	for i in monthAmount
		tempAmount = i["fail"]+i["success"]

		if (tempAmount>0)
		percFail = ((i["fail"]*100.00)/tempAmount).round(2)
		i["fail"] = percFail

		percSucc = ((i["success"]*100.00)/tempAmount).round(2)
		i["success"] = percSucc
		end
	end

	for i in 0..11
	   statistic[Date::MONTHNAMES[i+1]] = monthAmount[i]
	end

	return statistic
end

end