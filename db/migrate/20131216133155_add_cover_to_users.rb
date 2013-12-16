class AddCoverToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :cover_id, :integer
  end
end
