class Product < ActiveRecord::Base
  scope :published, -> { where("published_at IS NOT null") }

  has_many :messages, as: :messageable
  has_many :evaluates
  has_many :product_pictures
  has_many :collectionships, foreign_key: "product_id", dependent: :destroy
  has_many :collectors, through: :collectionships, source: :user
  belongs_to :product_category
  belongs_to :cover, class_name: "ProductPicture", foreign_key: "cover_id"
  
  validates :name, presence: true
  validates :product_category_id, presence: true

  def self.search_product this_params
    product = Product.all
    product = product.where("name LIKE ? ", "%#{this_params[:keywords]}%") unless this_params[:keywords].blank?
    product = product.where("price < ?", this_params[:max_price]) unless this_params[:max_price].blank?
    product = product.where("price > ?", this_params[:min_price]) unless this_params[:min_price].blank?
    product = product.where("product_category_id = ?", this_params[:product_category_id]) unless this_params[:product_category_id].blank?
    product
  end

  def feed
    Message.where("messageable_type = 'Product' AND messageable_id = ? ", id)
  end

  def product_picture_feed
    ProductPicture.where("product_id = ?", id)
  end

end
