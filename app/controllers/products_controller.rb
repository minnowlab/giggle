class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :find_product, only: :show

  def index
    @products = Product.classify_published(params[:category], params[:sort])
    @product_categories = ProductCategory.all
  end

  def show
    @evaluates = @product.evaluates.order("id desc").limit(5)
    @message = @product.messages.build
    @per_page = Message.per_page
    params[:page] = @product.last_page_with_per_page(@per_page) if params[:page].blank?
    @messages = @product.feed.paginate(page: params[:page], per_page: @per_page)
    @likeable = Likeship.likeable(@product)  
  end

  def preview_markdown
    render text: markdown(params[:body])
  end

  private

    def find_product
      @product = Product.find(params[:id])
    end
end
