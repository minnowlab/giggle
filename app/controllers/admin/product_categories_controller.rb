class Admin::ProductCategoriesController < Admin::BaseController
  before_action :find_product_category, only: [:show, :edit, :update, :destroy]

  def index
    @product_categories = ProductCategory.all
  end

  def show
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
      if @product_category.save
          flash.now[:success] = '创建成功！'
          redirect_to admin_product_categories_path
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @product_category.update(product_category_params)
      redirect_to admin_product_categories_path
    else
      render 'new'
    end
  end

  def destroy
    @product_category.destroy
    redirect_to admin_product_categories_path
  end

  private
    def product_category_params
      params.require(:product_category).permit(:name)
    end

    def find_product_category
      @product_category = ProductCategory.find(params[:id])
    end
end
