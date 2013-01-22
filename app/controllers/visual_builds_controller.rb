class VisualBuildsController < ApplicationController

	def index
	    @builds = VisualBuild.page(params[:page])
	    
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @builds }
	    end
	end

	def listBuildsForRepo
		repo_name = request.params[:repository_name]
		username = request.params[:username]

		@repo = VisualRepository.where("name = ? AND owner_name = ?", "#{repo_name}","#{username}")
		
		@repoBuilds = @repo[0].builds

		respond_to do |format|
			format.html # listBuildsForRepo.html.erb
			format.json { render json: @repoBuilds }
		end
	end

end
