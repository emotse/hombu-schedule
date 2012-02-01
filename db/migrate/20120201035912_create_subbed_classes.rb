class CreateSubbedClasses < ActiveRecord::Migration
  def change
    create_table :subbed_classes do |t|

      t.timestamps
    end
  end
end
