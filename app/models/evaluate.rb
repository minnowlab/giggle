class Evaluate < ActiveRecord::Base

  belongs_to :product, counter_cache: true
  belongs_to :user
  has_many :messages, as: :messageable
  has_many :likeships, as: :likeable, foreign_key: "likeable_id", dependent: :destroy
  has_many :likers, through: :likeships, source: :user

  validates :title, :details, :product_id, :user_id, presence: true

  def last_page_with_per_page per_page
    page = (self.messages_count.to_f / per_page).ceil
    page > 1 ? page : nil
  end

  def self.search this_params
    evaluate = Evaluate.all
    evaluate = evaluate.where("title LIKE ?", "%#{this_params[:title]}%") if this_params[:title].present?
    evaluate = evaluate.joins(:product).where("products.name LIKE ?", "%#{this_params[:product]}%") if this_params[:product].present?
    evaluate = evaluate.joins(:user).where("users.name LIKE ?", "%#{this_params[:user]}%") if this_params[:user].present?
    evaluate.paginate(page: this_params[:page])
  end

end
