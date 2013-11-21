class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
      t.string :title
      t.text :details
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
