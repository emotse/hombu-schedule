class AddConfirmableToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email
    end
  end

  def down
    remove_column :users, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  end
end
