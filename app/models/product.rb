class Product < ActiveRecord::Base
  validates :name, presence: true
end
