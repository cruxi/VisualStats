class StartController < ApplicationController

 def index
    respond_to do |format|
      format.html # index.html.erb
    end
 end


 def about
    respond_to do |format|
      format.html # about.html.erb
    end
 end

 def aboutUser

    @lastBuildsNumber = 5
    @lastJobsNumber = 10

    @user = request.params[:username]
    @repositories = VisualRepository.where(owner_name: @user)

    puts @repositories.length 

    @buildsArray = Array.new
    @jobsArray = Array.new


    repositoryIds = Array.new
    buildsIds = Array.new

    @repositories.each do |repository|
        repositoryIds << repository.id
    end

    @repositoriesCount = @repositories.length

    buildsIds    = VisualBuild.select(:id).where(:repository_id => repositoryIds).order("finished_at DESC")
    @buildsArray = VisualBuild.where(:repository_id => repositoryIds).where('finished_at IS NOT NULL').order("finished_at DESC").limit(@lastBuildsNumber)
    @buildsCount = buildsIds.length

    @jobsCount = VisualJob.where(:build_id => buildsIds).count
    @jobsArray = VisualJob.where(:build_id => buildsIds).where('finished_at IS NOT NULL').order("finished_at DESC").limit(@lastJobsNumber)
    
    respond_to do |format|
    	format.html {render :layout => false} # aboutUser.html.erb
    end
 end


 def userOverview
    respond_to do |format|
    	format.html # userOverview.html.erb
    end
 end

end
