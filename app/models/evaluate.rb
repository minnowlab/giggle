class Evaluate < ActiveRecord::Base
  validates :title, presence: true
  validates :details, presence: true
  validates :product_id, presence: true
  validates :user_id, presence: true
  belongs_to :product
  belongs_to :user

end
