class CreateScheduledClasses < ActiveRecord::Migration
  def change
    create_table :scheduled_classes do |t|
      t.string :name
      t.string :time
      t.string :type
      t.string :day

      t.timestamps
    end
  end
end
