class Likeship < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true
  validates :user_id, presence: true
  validates :likeable_id, presence: true
  validates :likeable_type, presence:true

  def self.likeable(like)
  	likeable = { likeable_type: like.class.to_s, likeable_id: like.id }
  	likeable
  end

end
