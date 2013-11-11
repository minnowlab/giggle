class Product < ActiveRecord::Base

  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
