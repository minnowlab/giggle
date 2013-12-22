class CollectionshipsController < ApplicationController
  before_action :signed_in_user
  before_action :find_product

  def create
  	current_user.collect!(@product)
    respond_to do |format|
      format.html { redirect_to :back }
  	  format.js
    end
  end

  def destroy
  	current_user.uncollect!(@product)
  	respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
    def find_product
      @product = Product.find(params[:product_id])
    end
end
