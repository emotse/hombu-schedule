class AddDayToScheduledClasses < ActiveRecord::Migration
  def change
    remove_column :scheduled_classes, :time
    add_column :scheduled_classes, :day, :string
    add_column :scheduled_classes, :time, :string
  end
end
