class RenameProductCategoryToProducts < ActiveRecord::Migration
  def change
    rename_column :products, :category_id, :product_category_id
  end
end
