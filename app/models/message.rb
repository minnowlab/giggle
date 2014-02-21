class Message < ActiveRecord::Base
  has_many :notifications
  belongs_to :messageable, polymorphic: true, counter_cache: true
  belongs_to :user

  after_create :track_notification

  validates :content, presence: true, length: { maximum: 300 }
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

  def evaluate_author? notification
    notification.user == notification.message.messageable.try(:user)
  end

  def self.per_page
    10
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
    message.paginate(page: this_params[:page])
  end

  private

  def track_notification
    track_users = []
    track_users << self.messageable.user if self.messageable.try(:user).present?
    track_users += find_user_in_content
    track_users.delete(self.user)
    track_users.uniq.each do |user|
      Notification.create! user_id: user.id, message_id: self.id   
    end
  end

  def format_user_in_content
    self.content.scan(/@([\w\u4e00-\u9fa5]{2,20})/).flatten
  end

  def find_user_in_content
    User.where(name: format_user_in_content)
  end
end
