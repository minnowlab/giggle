class Product < ActiveRecord::Base

  has_many :messages, dependent: :destroy
  belongs_to :product_category
  
  validates :name, presence: true
  validates :product_category_id, presence: true
end
