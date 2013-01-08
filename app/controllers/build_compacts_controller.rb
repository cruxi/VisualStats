class BuildCompactsController < ApplicationController
  # GET /build_compacts
  # GET /build_compacts.json
  def index
    @build_compacts = BuildCompact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @build_compacts }
    end
  end

  # GET /build_compacts/1
  # GET /build_compacts/1.json
  def show
    @build_compact = BuildCompact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @build_compact }
    end
  end

  # GET /build_compacts/new
  # GET /build_compacts/new.json
  def new
    @build_compact = BuildCompact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @build_compact }
    end
  end

  # GET /build_compacts/1/edit
  def edit
    @build_compact = BuildCompact.find(params[:id])
  end

  # POST /build_compacts
  # POST /build_compacts.json
  def create
    @build_compact = BuildCompact.new(params[:build_compact])

    respond_to do |format|
      if @build_compact.save
        format.html { redirect_to @build_compact, notice: 'Build compact was successfully created.' }
        format.json { render json: @build_compact, status: :created, location: @build_compact }
      else
        format.html { render action: "new" }
        format.json { render json: @build_compact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /build_compacts/1
  # PUT /build_compacts/1.json
  def update
    @build_compact = BuildCompact.find(params[:id])

    respond_to do |format|
      if @build_compact.update_attributes(params[:build_compact])
        format.html { redirect_to @build_compact, notice: 'Build compact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @build_compact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_compacts/1
  # DELETE /build_compacts/1.json
  def destroy
    @build_compact = BuildCompact.find(params[:id])
    @build_compact.destroy

    respond_to do |format|
      format.html { redirect_to build_compacts_url }
      format.json { head :no_content }
    end
  end

  def getJobs
    queryParams = request.query_parameters
    @jobs = BuildCompact.getData(queryParams[:lang1],queryParams[:lang2],queryParams[:amount])

    respond_to do |format|
      format.json { render json: @jobs }
    end

  end 

end
