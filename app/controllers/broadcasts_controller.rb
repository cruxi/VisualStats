class BroadcastsController < ApplicationController
  # GET /broadcasts
  # GET /broadcasts.json
  def index
    @broadcasts = Broadcast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @broadcasts }
    end
  end

  # GET /broadcasts/1
  # GET /broadcasts/1.json
  def show
    @broadcast = Broadcast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @broadcast }
    end
  end

  # GET /broadcasts/new
  # GET /broadcasts/new.json
  def new
    @broadcast = Broadcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @broadcast }
    end
  end

  # GET /broadcasts/1/edit
  def edit
    @broadcast = Broadcast.find(params[:id])
  end

  # POST /broadcasts
  # POST /broadcasts.json
  def create
    @broadcast = Broadcast.new(params[:broadcast])

    respond_to do |format|
      if @broadcast.save
        format.html { redirect_to @broadcast, notice: 'Broadcast was successfully created.' }
        format.json { render json: @broadcast, status: :created, location: @broadcast }
      else
        format.html { render action: "new" }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /broadcasts/1
  # PUT /broadcasts/1.json
  def update
    @broadcast = Broadcast.find(params[:id])

    respond_to do |format|
      if @broadcast.update_attributes(params[:broadcast])
        format.html { redirect_to @broadcast, notice: 'Broadcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @broadcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /broadcasts/1
  # DELETE /broadcasts/1.json
  def destroy
    @broadcast = Broadcast.find(params[:id])
    @broadcast.destroy

    respond_to do |format|
      format.html { redirect_to broadcasts_url }
      format.json { head :no_content }
    end
  end
end
