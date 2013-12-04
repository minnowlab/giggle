class Evaluate < ActiveRecord::Base

  validates :title, presence: true
  validates :details, presence: true
  validates :product_id, presence: true
  validates :user_id, presence: true
  belongs_to :product
  belongs_to :user
  has_many :messages

  def feed
    Message.where("evaluate_id = ?", id)
  end

  def self.search_evaluate this_params
    evaluate = Evaluate.all
    evaluate = evaluate.where("title LIKE ?", "%#{this_params[:title]}%") if this_params[:tittle].present?
    products_ids = Product.where("name like ?", this_params[:product]).map(&:id)
    evaluate = evaluate.where(product_id: products_ids) if this_params[:product].present?
    evaluate
  end

end
