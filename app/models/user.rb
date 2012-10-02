class User < ActiveRecord::Base
  serialize :watched_classes, Array
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :watched_classes

  def add_to_watched_classes watched_classes
    watched_classes.each do |watched_class|
      self.watched_classes << watched_class if !self.watched_classes.include?(watched_class)
      self.save
    end
  end

  def remove_from_watched_classes watched_classes
    watched_classes.each do |watched_class|
      self.watched_classes.delete(watched_class)
      self.save
    end
  end
end
