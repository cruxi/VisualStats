class VisualBuildsController < ApplicationController

	def index
	    @builds = VisualBuild.page(params[:page])

	    @draw = Array.new 

	    amount =  VisualBuild.count()
	    amount.to_i
	    success =  VisualBuild.where(:result => 1).count()
	    fail = VisualBuild.where(:result => 0).count()
		
		@draw << ['no result', amount-fail-success]
	    @draw << ['fail', fail.to_i]
	    @draw << ['success', success.to_i]

	    
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @builds }
	    end
	end

	def listBuildsForRepo
		repo_name = request.params[:repository_name]
		username = request.params[:username]

		@repo = VisualRepository.where(name: repo_name).where(owner_name: username)
		
		@repoBuilds = @repo[0].builds

		respond_to do |format|
			format.html  {render :layout => false} # listBuildsForRepo.html.erb
			format.json { render json: @repoBuilds }
		end
	end


	def listBuildsForUser
		@username = request.params[:username]

		#repository -> named assocation in model 
		#visual_repositories -> db table name
		@builds = VisualBuild.joins(:repository).where(:visual_repositories => {:owner_name => @username}).order("finished_at desc").page(params[:page])
		

		respond_to do |format|
			format.html  {render :layout => false} # listBuildsForRepo.html.erb
			format.json { render json: @builds }
		end
	end

	def listBuildsForLanguage
		@language = request.params[:language]

		#repository -> named assocation in model 
		#visual_repositories -> db table name
		@builds = VisualBuild.where(:language => @language).order("finished_at desc").page(params[:page])
		

		respond_to do |format|
			format.html  {render :layout => false} # listBuildsForRepo.html.erb
			format.json { render json: @builds }
		end
	end

	
	def showBuild
	    @build =  VisualBuild.find(params[:build_id])
		#benutzen wenn es diagramm gibt
		#@draw = VisualRepository.getRepositoryDrawData(params[:repository_id]).to_json

		ui = request.params[:ui].to_i
		puts ui

		if(ui > 0)
			respond_to do |format|
				format.html # showRepository.html.erb
				format.json { render json: @build }
			end
		else
			respond_to do |format|
				format.html { render :layout => 'frame' }
				format.json { render json: @build }
			end
		end
	end
end
