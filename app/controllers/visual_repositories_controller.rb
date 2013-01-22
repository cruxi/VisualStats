class VisualRepositoriesController < ApplicationController
	
	def listReposForUser
		username = request.params[:username]
		@repositories = VisualRepository.where("owner_name = ?", "#{username}")

		respond_to do |format|
			format.html # listReposForUser.html.erb
			format.json { render json: @repositories }
		end
	end
end
