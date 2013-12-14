class Product < ActiveRecord::Base

  has_many :messages, :as => :messageable
  has_many :evaluates
  has_many :product_pictures
  belongs_to :product_category
  
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
    Message.where("messageable_type LIKE ? AND messageable_id = ? ", "%Product%", id)
  end
end
