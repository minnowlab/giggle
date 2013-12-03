class Product < ActiveRecord::Base

  has_many :messages
  has_many :evaluates
  has_many :product_pictures
  belongs_to :product_category
  
  validates :name, presence: true
  validates :product_category_id, presence: true
end
