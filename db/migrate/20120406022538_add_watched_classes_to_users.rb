class AddWatchedClassesToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.text :watched_classes
    end
  end

  def down
    remove_column :watched_classes
  end
end
