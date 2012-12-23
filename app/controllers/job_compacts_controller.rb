class JobCompactsController < ApplicationController
  # GET /job_compacts
  # GET /job_compacts.json
  def index
    @job_compacts = JobCompact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_compacts }
    end
  end

  # GET /job_compacts/1
  # GET /job_compacts/1.json
  def show
    @job_compact = JobCompact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_compact }
    end
  end

  # GET /job_compacts/new
  # GET /job_compacts/new.json
  def new
    @job_compact = JobCompact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_compact }
    end
  end

  # GET /job_compacts/1/edit
  def edit
    @job_compact = JobCompact.find(params[:id])
  end

  # POST /job_compacts
  # POST /job_compacts.json
  def create
    @job_compact = JobCompact.new(params[:job_compact])

    respond_to do |format|
      if @job_compact.save
        format.html { redirect_to @job_compact, notice: 'Job compact was successfully created.' }
        format.json { render json: @job_compact, status: :created, location: @job_compact }
      else
        format.html { render action: "new" }
        format.json { render json: @job_compact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /job_compacts/1
  # PUT /job_compacts/1.json
  def update
    @job_compact = JobCompact.find(params[:id])

    respond_to do |format|
      if @job_compact.update_attributes(params[:job_compact])
        format.html { redirect_to @job_compact, notice: 'Job compact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_compact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_compacts/1
  # DELETE /job_compacts/1.json
  def destroy
    @job_compact = JobCompact.find(params[:id])
    @job_compact.destroy

    respond_to do |format|
      format.html { redirect_to job_compacts_url }
      format.json { head :no_content }
    end
  end
end
