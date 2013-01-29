class VisualRepositoriesController < ApplicationController
	
	def listReposForUser
		@username = request.params[:username]
		@repositories = VisualRepository.where(owner_name: @username)

		respond_to do |format|
			format.html {render :layout => false} 
			format.json { render json: @repositories } # listReposForUser.html.erb
		end
	end


	def index
	    @repositories =  VisualRepository.page(params[:page])

	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @repositories }
	    end
	end


	def showRepository
	    @repository =  VisualRepository.find(params[:repository_id])
		@draw = VisualRepository.getRepositoryDrawData(params[:repository_id]).to_json

		ui = request.params[:ui].to_i
		puts ui

		if(ui > 0)
			respond_to do |format|
				format.html # showRepository.html.erb
				format.json { render json: @repository }
			end
		else
			respond_to do |format|
				format.html { render :layout => 'frame' }
				format.json { render json: @repository }
			end
		end
	end
	
end
