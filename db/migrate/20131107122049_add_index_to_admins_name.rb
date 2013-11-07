class AddIndexToAdminsName < ActiveRecord::Migration
  def change
  add_index :admins, :name, unique: true
  end
end
