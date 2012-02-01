class CreateScheduledClasses < ActiveRecord::Migration
  def change
    create_table :scheduled_classes do |t|
      t.datetime :time

      t.timestamps
    end
  end
end
