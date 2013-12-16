class AddCoverIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cover_id, :integer
    remove_column :product_pictures, :cover, :boolean
  end
end
