class CollabsController < ApplicationController
  # GET /collabs
  # GET /collabs.json
  def index
    @collabs = Collab.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @collabs }
    end
  end

  # GET /collabs/1
  # GET /collabs/1.json
  def show
    @collab = Collab.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'collab'}# show.html.erb
      format.json { render json: @collab }
    end
  end

  # GET /collabs/new
  # GET /collabs/new.json
  def new
    @collab = Collab.new
    @collab.course_id = params[:course_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @collab }
    end
  end

  # GET /collabs/1/edit
  def edit
    @collab = Collab.find(params[:id])
  end

  # POST /collabs
  # POST /collabs.json
  def create
    @collab = Collab.new(params[:collab])

    respond_to do |format|
      if @collab.save
        format.html { redirect_to @collab, notice: 'Collab was successfully created.' }
        format.json { render json: @collab, status: :created, location: @collab }
      else
        format.html { render action: "new" }
        format.json { render json: @collab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /collabs/1
  # PUT /collabs/1.json
  def update
    @collab = Collab.find(params[:id])

    respond_to do |format|
      if @collab.update_attributes(params[:collab])
        format.html { redirect_to @collab, notice: 'Collab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collabs/1
  # DELETE /collabs/1.json
  def destroy
    @collab = Collab.find(params[:id])
    @collab.destroy

    respond_to do |format|
      format.html { redirect_to collabs_url }
      format.json { head :no_content }
    end
  end
end
