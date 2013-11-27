class Message < ActiveRecord::Base

  belongs_to :product
  belongs_to :user
  belongs_to :evaluate
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }

  def self.sort(sort)
   if sort.nil?
  	all 
    else
  	where("#{sort}_id IS NULL")
   end
  end
end
