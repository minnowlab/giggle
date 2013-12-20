class AddPublishedAtAndBuyLinkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published_at, :datetime
    add_column :products, :buy_link, :string
  end
end
