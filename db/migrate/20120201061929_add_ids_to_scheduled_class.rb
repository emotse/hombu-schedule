class AddIdsToScheduledClass < ActiveRecord::Migration
  def change
    add_column :scheduled_classes, :shihan_id, :integer
  end
end
