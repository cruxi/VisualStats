class VisualJobsController < ApplicationController

	def index
	    @jobs =  VisualJob.page(params[:page])

	    @draw = Array.new 

	    amount =  VisualJob.count()
	    amount.to_i
	    success =  VisualJob.where(:result => 1).count()
	    fail = VisualJob.where(:result => 0).count()
		
		@draw << ['no result', amount-fail-success]
	    @draw << ['fail', fail.to_i]
	    @draw << ['success', success.to_i]

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @jobs }
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

		#@builds = VisualBuild.joins(:repository).where(:visual_repositories => {:owner_name => @username}).order("finished_at desc")
		@jobs = VisualJob.joins(:build => :repository).where(:visual_repositories => {:owner_name => @username}).order("finished_at desc").page(params[:page])

		respond_to do |format|
			format.html {render :layout => false} # listJobsForUser.html.erb
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

end
