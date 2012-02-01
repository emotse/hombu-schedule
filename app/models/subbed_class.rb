class SubbedClass < ActiveRecord::Base
  belongs_to :scheduled_classes
  belongs_to :sub
end
