class CreateShihans < ActiveRecord::Migration
  def change
    create_table :shihans do |t|
      t.string :name_en
      t.string :name_jp

      t.timestamps
    end
  end
end
