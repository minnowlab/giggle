class Product < ActiveRecord::Base

  has_many :messages
  has_many :evaluates
  has_many :product_pictures
  belongs_to :product_category
  
  validates :name, presence: true
  validates :product_category_id, presence: true

 def self.search(key)
    if key.blank?
      all
    else 
      where("name LIKE ? AND price < ? AND price > ? AND product_category_id = ?", key[:keyword], key[:high_price], key[:low_price], key[:product_category_id])
    end
  end

end
