class ScheduledClassesController < ApplicationController
  # GET /scheduled_classes
  # GET /scheduled_classes.json
  def index
    @scheduled_classes = ScheduledClass.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scheduled_classes }
    end
  end

  # GET /scheduled_classes/1
  # GET /scheduled_classes/1.json
  def show
    @scheduled_class = ScheduledClass.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scheduled_class }
    end
  end

  # GET /scheduled_classes/new
  # GET /scheduled_classes/new.json
  def new
    @scheduled_class = ScheduledClass.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scheduled_class }
    end
  end

  # GET /scheduled_classes/1/edit
  def edit
    @scheduled_class = ScheduledClass.find(params[:id])
  end

  # POST /scheduled_classes
  # POST /scheduled_classes.json
  def create
    @scheduled_class = ScheduledClass.new(params[:scheduled_class])

    respond_to do |format|
      if @scheduled_class.save
        format.html { redirect_to @scheduled_class, notice: 'Scheduled class was successfully created.' }
        format.json { render json: @scheduled_class, status: :created, location: @scheduled_class }
      else
        format.html { render action: "new" }
        format.json { render json: @scheduled_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scheduled_classes/1
  # PUT /scheduled_classes/1.json
  def update
    @scheduled_class = ScheduledClass.find(params[:id])

    respond_to do |format|
      if @scheduled_class.update_attributes(params[:scheduled_class])
        format.html { redirect_to @scheduled_class, notice: 'Scheduled class was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @scheduled_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduled_classes/1
  # DELETE /scheduled_classes/1.json
  def destroy
    @scheduled_class = ScheduledClass.find(params[:id])
    @scheduled_class.destroy

    respond_to do |format|
      format.html { redirect_to scheduled_classes_url }
      format.json { head :ok }
    end
  end
end
