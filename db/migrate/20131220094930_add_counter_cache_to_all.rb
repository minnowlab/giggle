class AddCounterCacheToAll < ActiveRecord::Migration
  def up
    add_column :products, :messages_count, :integer, default: 0
    add_column :products, :evaluates_count, :integer, default: 0
    add_column :evaluates, :messages_count, :integer, default: 0

    Product.reset_column_information
    Evaluate.reset_column_information
    Product.all.each do |product|
      product.update(messages_count: product.messages.length, evaluates_count: product.evaluates.length)
    end
    Evaluate.all.each do |evaluate|
      evaluate.update(messages_count: evaluate.messages.length)
    end
  end

  def down
    remove_column :products, :messages_count
    remove_column :products, :evaluates_count
    remove_column :evaluates, :messages_count
  end
end
