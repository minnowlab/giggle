class Message < ActiveRecord::Base
  belongs_to :product
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :product_id, presence: true
end
