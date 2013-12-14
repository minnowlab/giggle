class Evaluate < ActiveRecord::Base

  belongs_to :product
  belongs_to :user
  has_many :messages, :as => :messageable

  validates :title, presence: true
  validates :details, presence: true
  validates :product_id, presence: true
  validates :user_id, presence: true

  def feed
    Message.where("messageable_type LIKE ? AND messageable_id = ?", "%Evaluate%", id)
  end

  def self.search_evaluate this_params
    products_ids = Product.where("name like ?", "%#{this_params[:product]}%").map(&:id) if this_params[:product].present?
    users_ids = User.where("name LIKE ?", "%#{this_params[:user]}%").map(&:id) if this_params[:user].present?
    evaluate = Evaluate.all
    evaluate = evaluate.where("title LIKE ?", "%#{this_params[:title]}%") if this_params[:title].present?
    evaluate = evaluate.where(product_id: products_ids) if this_params[:product].present?
    evaluate = evaluate.where(user_id: users_ids) if this_params[:user].present?
    evaluate
  end

end
