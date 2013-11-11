class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :product_id

      t.timestamps
    end
    add_index :messages, [:product_id, :created_at]
  end
end
