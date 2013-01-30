class WebhooksController < ApplicationController
  # POST /notify/:username/:repository
  def notify
    username = params[:username]
    repository =  params[:repository]
    payload = params[:payload]
    authorized = authorize_notification(username,repository,request.headers['Authorization'])
   # @call_back = CallBack.new(params) would probably work, too
    @visual_build = VisualBuild.create_from_json_str(payload)
    respond_to do |format|
      if @visual_build.save
        format.html { redirect_to @visual_build, notice: 'Build was successfully created.' }
        format.json { render json: @visual_build, status: :created, location: @visual_build }
      else
        format.html { render action: "new" }
        format.json { render json: @visual_build.errors, status: :unprocessable_entity }
      end
    end
  end
  def authorize_notification(username,repository,sha256)
    token = "h5Rpd7dqe2zbV8XFawzo"
    hash =  Digest::SHA256.hexdigest("#{username}/#{repository}#{token}")
    return (hash == sha256)
    #note = (hash == sha256) ? "AUTHORIZED " : "NOT AUTHORIZED "
    #note += sha256 if sha256
    #note
  end
end
