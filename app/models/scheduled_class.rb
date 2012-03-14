class ScheduledClass < ActiveRecord::Base
  validates :time, :uniqueness => {:scope => [:day, :shihan_id]}
  belongs_to :shihan
  has_many :subbed_classes
end
