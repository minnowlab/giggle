class DropAdminTable < ActiveRecord::Migration
  def up
    drop_table :admins
  end

  def down
    create_table :admins do |t|
      t.string :name
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end

    add_index :admins, :remember_token
  end
end
