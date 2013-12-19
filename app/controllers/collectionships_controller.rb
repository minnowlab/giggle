class CollectionshipsController < ApplicationController
  before_action :signed_in_user

  def create
  	@product = Product.find(params[:collectionship][:product_id])
  	current_user.collect!(@product)
  	redirect_to :back
  end

  def destroy
  	@product = Collectionship.find(params[:id]).product
  	current_user.uncollect!(@product)
  	redirect_to :back
  end
end
