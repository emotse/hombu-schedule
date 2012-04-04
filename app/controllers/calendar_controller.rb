class CalendarController < ApplicationController
  before_filter :authenticate_user!

  # GET /calendar
  def index
    @days = ScheduledClass.get_days
    @times = ScheduledClass.get_times

    @teachers = []
    @days.each do |day|
      @times.each do |time|
        teacher = ScheduledClass.get_by_day_and_time( day.day, time.time )
        if teacher.length > 0
          teacher.each do |duplicate|
            @teachers << duplicate.shihan
          end
        else
          @teachers << {:name_en => ""}
        end
      end
    end
    respond_to do |format|
      format.html
    end
  end
end
