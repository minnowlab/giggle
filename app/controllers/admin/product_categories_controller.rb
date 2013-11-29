class Admin::ProductCategoriesController < Admin::BaseController
  before_action :find_product_category, only: [:show, :edit, :update, :destroy, :all]

  def index
    @product_categories = ProductCategory.page(params[:page])
  end

  def show
    @products = @product_category.products
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      flash[:success] = '创建成功！'
      redirect_to admin_product_categories_path
    else
      flash.now[:danger] = '创建失败，请重新创建！'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product_category.update(product_category_params)
      flash[:success] = '更新成功！'
      redirect_to admin_product_categories_path
    else
      flash.now[:danger] = '更新失败，请重新更新！'
      render 'new'
    end
  end

  def destroy
    @product_category.destroy
    @product_categories = ProductCategory.page(params[:page])
    flash[:success] = '删除成功！'
    if @product_categories.blank?
      redirect_to admin_product_categories_path
    else
      redirect_to :back
    end
  end

  private
    def product_category_params
      params.require(:product_category).permit(:name)
    end

    def find_product_category
      @product_category = ProductCategory.find(params[:id])
    end
end
