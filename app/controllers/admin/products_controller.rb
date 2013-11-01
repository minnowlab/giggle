class Admin::ProductsController < ApplicationController
  layout "admin"

  def index
    @products=Product.all
  end

  def show
    @product=Product.find(params[:id])
  end

  def new
    @product=Product.new
  end

  def create
    @product=Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render 'new'
    end
  end

  def edit
    @product=Product.find(params[:id])
  end

  def update
    if @product.update_attributes(product_params)
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
  end

  private

  def product_params
    params.require(:product).permit(:name,:description,:detail,:price)
  end
end
