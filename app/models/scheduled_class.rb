class ScheduledClass < ActiveRecord::Base
  belongs_to :shihan
  has_many :subbed_classes
end
