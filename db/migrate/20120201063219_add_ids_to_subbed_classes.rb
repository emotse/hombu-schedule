class AddIdsToSubbedClasses < ActiveRecord::Migration
  def change
    add_column :subbed_classes, :scheduled_class_id, :integer
    add_column :subbed_classes, :sub_id, :integer
  end
end
