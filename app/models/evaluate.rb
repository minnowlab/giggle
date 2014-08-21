class Evaluate < ActiveRecord::Base

  belongs_to :product, counter_cache: true
  belongs_to :user
  has_many :messages, as: :messageable
  has_many :likeships, as: :likeable, foreign_key: "likeable_id", dependent: :destroy
  has_many :likers, through: :likeships, source: :user

  validates :title, presence: true
  validates :details, presence: true
  validates :product_id, presence: true
  validates :user_id, presence: true

  def last_page_with_per_page per_page
    page = (self.messages_count.to_f / per_page).ceil
    page > 1 ? page : nil
  end

  def self.search_evaluate this_params
    products_ids = Product.where("name like ?", "%#{this_params[:product]}%").map(&:id) if this_params[:product].present?
    users_ids = User.where("name LIKE ?", "%#{this_params[:user]}%").map(&:id) if this_params[:user].present?
    evaluate = Evaluate.all
    evaluate = evaluate.where("title LIKE ?", "%#{this_params[:title]}%") if this_params[:title].present?
    evaluate = evaluate.where(product_id: products_ids) if this_params[:product].present?
    evaluate = evaluate.where(user_id: users_ids) if this_params[:user].present?
    evaluate.paginate(page: this_params[:page])
  end

end
