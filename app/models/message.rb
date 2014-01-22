class Message < ActiveRecord::Base
  has_many :notifications
  belongs_to :messageable, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :content, presence: true, length: { maximum: 250 }
  validates :messageable_type, inclusion: { in: %w(Product Evaluate),
                                            message: "%{value} is not a valid type" }

  TYPE_NAME = {"Product"=>"产品", "Evaluate"=>"评测"}

  def messageable_cn
    TYPE_NAME[self.messageable_type] 
  end

  def messageable_name
    case self.messageable_type
    when "Product"
      self.messageable.try(:name)
    when "Evaluate"
      self.messageable.try(:title)
    end
  end

  def self.per_page
    25
  end

  def self.message_search this_params
    message = Message.all
    products_ids = Product.where("name LIKE ?", "%#{this_params[:product]}%").map(&:id) if this_params[:product].present?
    evaluates_ids = Evaluate.where("title LIKE ?", "%#{this_params[:evaluate]}%").map(&:id) if this_params[:evaluate].present?
    users_ids = User.where("name LIKE ?", "%#{this_params[:user]}%").map(&:id) if this_params[:user].present?
    message = message.where("content LIKE ?", "%#{this_params[:content]}%") if this_params[:content].present?
    message = message.where("messageable_type = 'Product' AND messageable_id = ?", products_ids) if this_params[:product].present?
    message = message.where("messageable_type = 'Evaluate' AND messageable_id = ?", evaluates_ids) if this_params[:evaluate].present?
    message = message.where(user_id: users_ids) if this_params[:user].present?
    message = message.where(messageable_type: this_params[:sort]) if this_params[:sort].present?
    message
  end

  def track_notification current_user
    note_user = inc_user
    track_users = []
    evaluate = messageable 
    track_users << evaluate.user
    track_users = track_users + evaluate.likers + note_user
    track_users.delete(current_user)
    track_users.uniq.each do |user|
      Notification.create! user_id: user.id, message_id: id   
    end
  end

  def inc_user
    note_users = self.content.scan(/@(\w{2,20})/).flatten
    note_users = User.where(name: note_users) if note_users.any?
    note_users
  end

  def find_note_user name
    user = User.where("name = ?", name).first
  end

end
