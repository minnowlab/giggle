class AddRememberTokenToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :remember_token, :string
    add_index :admins, :remember_token
  end
end
