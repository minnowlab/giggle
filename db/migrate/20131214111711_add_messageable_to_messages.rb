class AddMessageableToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :messageable_type, :string
  	add_column :messages, :messageable_id, :integer
  	remove_column :messages, :product_id, :integer
  	remove_column :messages, :evaluate_id, :integer
  end
end
