class Product < ActiveRecord::Base
  scope :published, -> { where("published_at IS NOT null") }

  has_many :messages, as: :messageable
  has_many :evaluates
  has_many :product_pictures
  has_many :collectionships, foreign_key: "product_id", dependent: :destroy
  has_many :collectors, through: :collectionships, source: :user
  has_many :likeships, as: :likeable, foreign_key: "likeable_id", dependent: :destroy
  has_many :likers, through: :likeships, source: :user
  belongs_to :product_category
  belongs_to :cover, class_name: "ProductPicture", foreign_key: "cover_id"

  validates :name, :product_category_id, presence: true

  def last_page_with_per_page per_page
    page = (self.messages_count.to_f / per_page).ceil
    page > 1 ? page : nil
  end

  def self.search this_params
    product = self.all
    product = product.where("name LIKE ? ", "%#{this_params[:name]}%") if this_params[:name].present?
    product = product.where("price < ?", this_params[:max_price]) if this_params[:max_price].present?
    product = product.where("price > ?", this_params[:min_price]) if this_params[:min_price].present?
    product = product.where(product_category_id: this_params[:product_category_id]) if this_params[:product_category_id].present?
    product.paginate(page: this_params[:page])
  end

  def self.classify_published this_params
    product = Product.published
    product = product.where(product_category_id: this_params[:category]) if this_params[:category].present?
    product.paginate(page: this_params[:page], per_page: 6)
  end

end
