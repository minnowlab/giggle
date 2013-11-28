class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page])
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    @products = Product.page(params[:page])
    if @products.blank?
      redirect_to admin_products_path
    else
      redirect_to :back
    end
  end

  private
  
    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :details, :price, :product_category_id)
    end
end
