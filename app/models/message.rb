class Message < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  belongs_to :evaluate
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }

end
