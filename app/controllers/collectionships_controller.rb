class CollectionshipsController < ApplicationController
  before_action :signed_in_user

  def create
  	@product = Product.find(params[:collectionship][:product_id])
  	current_user.collect!(@product)
    respond_to do |format|
      format.html { redirect_to :back }
  	  format.js
    end
  end

  def destroy
  	@product = Collectionship.find(params[:id]).product
  	current_user.uncollect!(@product)
  	respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
