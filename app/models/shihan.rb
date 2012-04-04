class Shihan < ActiveRecord::Base
  validates :name_en, :uniqueness => true
  has_many :scheduled_classes
end
