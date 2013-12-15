class Message < ActiveRecord::Base

  belongs_to :messageable, :polymorphic => true
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }

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

end
