class AddCoverToProductPictures < ActiveRecord::Migration
  def change
    add_column :product_pictures, :cover, :boolean, default: false
    remove_column :product_pictures, :choice, :boolean
  end
end
