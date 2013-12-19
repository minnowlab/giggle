class CreateCollectionships < ActiveRecord::Migration
  def change
    create_table :collectionships do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
    add_index :collectionships, [:user_id, :product_id], unique: true
  end
end
