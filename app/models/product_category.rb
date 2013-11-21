class ProductCategory < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false } 
  has_many :products
end
