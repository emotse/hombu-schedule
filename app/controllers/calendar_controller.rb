class CalendarController < ApplicationController
  # GET /calendar
  def index
    @days = ScheduledClass.get_days
    @times = ScheduledClass.get_times

    respond_to do |format|
      format.html
    end
  end
end
