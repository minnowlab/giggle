class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :setting_cover]

  def index
    @products = Product.search_product(params).page(params[:page])
  end

  def show
    @product_picture = ProductPicture.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = '创建成功！'
      redirect_to admin_products_path
    else
      flash.now[:danger] = '创建失败，请重新创建！'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = '更新成功！'
      redirect_to admin_products_path
    else
      flash.now[:danger] = '更新失败，请重新更新！'
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    @products = Product.page(params[:page])
    flash[:success] = '删除成功！'
    if @products.blank?
      redirect_to admin_products_path
    else
      redirect_to :back
    end
  end

  def setting_cover
    @product_picture = @product.product_pictures.where(id: params[:cover_id]).first
    @product.update(cover: @product_picture)
    flash[:success] = '设置成功成功！'
    redirect_to :back
  end

  private
  
    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :details, :price, :product_category_id)
    end
end
