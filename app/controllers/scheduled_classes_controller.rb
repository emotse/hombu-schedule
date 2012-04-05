class ScheduledClassesController < ApplicationController
  def index
    @scheduled_classes = ScheduledClass.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @scheduled_class = ScheduledClass.find params[:id]

    respond_to do |format|
      format.html
    end
  end

end
