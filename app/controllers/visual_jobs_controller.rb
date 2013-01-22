class VisualJobsController < ApplicationController

	def index
	    @jobs =  VisualJob.page(params[:page])

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @jobs }
	    end
	end

	def listLanguages
		@languages = Hash.new
		@distinctLanguages = VisualJob.select(:language).uniq	

		@distinctLanguages.each do |lang| 
			langTemp = lang.language
			@languages[langTemp] = VisualJob.where("language = ?", "#{langTemp}").count(:language)
		end

		respond_to do |format|
			format.html # listLanguages.html.erb
			format.json { render json: @languages }
		end
	end

	
	def listJobsForBuild
		@repo_name = request.params[:repository_name]
		@username = request.params[:username]
		@build_number = request.params[:build_number]

		@repo = VisualRepository.where("name = ? AND owner_name = ?", "#{@repo_name}","#{@username}")
		
		@repoBuild = @repo[0].builds.where("number = ?", "#{@build_number}")
		@jobs = @repoBuild[0].jobs

		respond_to do |format|
			format.html # listJobsForBuild.html.erb
			format.json { render json: @jobs }
		end
	end

	def listJobsForUser
		@username = request.params[:username]

		@repos = VisualRepository.where("owner_name = ?", "#{@username}")
		@jobs = Array.new

		@repos.each do |repo|
			builds = repo.builds
			builds.each do |build|
				tempjobs = build.jobs
				tempjobs.each do |job|
					@jobs << job
				end
			end
		end

		respond_to do |format|
			format.html # listJobsForUser.html.erb
			format.json { render json: @jobs }
		end
	end

	
	def listJobsForLanguage
		@language = request.params[:language]
		@jobs = VisualJob.where("language = ?", "#{@language}")

		respond_to do |format|
			format.html # listJobsForLanguage.html.erb
			format.json { render json: @jobs }
		end
	end

	def listJobsForLanguages
		@languages = Array.new 

		reg = Regexp.new('^language[1-5]$')

		request.params.each do |param, lang|
			if reg.match(param)
				@languages << lang
			end
		end

		@languageStats = Array.new

		@languages.each do |lang|
			stat = Hash.new
			stat['language'] = lang
			#stat['positiv'] = VisualJob.where("language = '#{lang}' AND result=1").count

			#besser aufgrund von SQL injection!!
			stat['positiv'] = VisualJob.where(language: lang).where(result: 1).count

			stat['negativ'] = VisualJob.where("language = '#{lang}' AND result=0").count
			stat['total'] = VisualJob.where("language = '#{lang}'").count
			if stat['total'] > 0 
				stat['percentage'] = (stat['positiv']*100.0/stat['total']).round(2)
			else
				stat['percentage'] = (0).round(2)
			end
			@languageStats << stat
		end

		@stats = Hash.new
		@stats['languageStats']=@languageStats
		@stats['draw']=VisualBuild.getJobs(@languages[0],@languages[1],1000).to_json

		respond_to do |format|
			format.html # listJobsForLanguages.html.erb
			format.json { render json: @stats }
		end
	end

	def listJobsForDimension
		@language = request.params[:language]
		@version1 = request.params[:version1]
		@version2 = request.params[:version2]


		@dimensions = VisualDimension.where("visual_dimensions.key = '#{@language}' AND (visual_dimensions.value='#{@version1}' OR visual_dimensions.value='#{@version2}')").count

		respond_to do |format|
			format.html # listJobsForDimension.html.erb
			format.json { render json: @dimensions }
		end

	end	


end
