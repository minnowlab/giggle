class Admin::ProductsController < Admin::BaseController
  before_action :find_product, except: [:index, :new, :create]

  def index
    @products = Product.search(params)
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
      redirect_to admin_product_path(@product)
    else
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
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    @products = Product.search(params)
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

  def publish_operation
    publish_setting = @product.published_at.nil? ? Time.now : nil
    if @product.update(published_at: publish_setting)
      flash[:success] = '设置成功！'
      redirect_to admin_product_path(@product)
    else
      flash[:danger] = '设置失败，请重新设置！'
      redirect_to :back
    end
  end

  private
  
    def find_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :details, :buy_link, :price, :product_category_id)
    end
end
