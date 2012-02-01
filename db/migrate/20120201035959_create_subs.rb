class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name_en
      t.string :name_jp

      t.timestamps
    end
  end
end
