class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :create_product_picture]

  def index
    @products = Product.search(params).page(params[:page])
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

  def create_product_picture
    @product_picture = @product.product_pictures.build(product_picture_params)
    if @product_picture.save
      flash[:success] = '成功创建产品图片！'
      redirect_to :back
    else
      flash.now[:danger] = '创建产品图片失败，请重新创建！'
      render 'show'
    end
  end

  private
  
    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :details, :price, :product_category_id)
    end

    def product_picture_params
      params.require(:product_picture).permit(:picture)
    end

end
