class Collectionship < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates :user_id, :product_id, presence: true
end
