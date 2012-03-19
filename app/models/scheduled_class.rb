class ScheduledClass < ActiveRecord::Base
  validates :time, :uniqueness => {:scope => [:day, :shihan_id]}
  belongs_to :shihan
  has_many :subbed_classes

  def self.get_days
    days = ScheduledClass.select(:day)
    days.uniq { |day| day.day }
  end

  def self.get_times
    times = ScheduledClass.select(:time)
    times.uniq! { |time| time.time }
    times.sort { |x, y| x.time <=> y.time }
  end

  def self.get_by_day_and_time day, time
    ScheduledClass.where([:day => day, :time => time])
  end
end
