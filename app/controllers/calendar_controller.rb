class CalendarController < ApplicationController
  # GET /calendar
  def index
    @scheduled_classes = ScheduledClass.all

    respond_to do |format|
      format.html
    end
  end
end
