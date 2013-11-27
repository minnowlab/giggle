class CreateProductPictures < ActiveRecord::Migration
  def change
    create_table :product_pictures do |t|
      t.string :picture
      t.boolean :choice
      t.string :picture_content_type
      t.integer :picture_file_size
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end
