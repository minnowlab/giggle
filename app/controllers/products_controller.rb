class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :create_message]

  def index
    @products = Product.all
  end

  def show
    @evaluates = @product.evaluates.order("created_at desc").limit(5)
    @message = @product.messages.build
    @message_items = @product.feed.page(params[:page])
  end
 
  def create_message
    @message = @product.messages.build(messages_params.merge(user: current_user))
    respond_to do |format|
      if @message.save
        format.html { redirect_to @product }
        format.js
      else
        format.html { render 'show' }
        format.js
      end
    end
  end

  def destroy_message
    @message = Message.find(params[:message_id])
    @product = @message.product
    @message.destroy
    flash[:success] = '删除成功！'
    redirect_to @product
  end

  def edit_message
    
  end

  def update_message
    
  end

  private

    def find_product
      @product = Product.find(params[:id])
    end

    def messages_params
      params.require(:message).permit(:content, :product_id)
      
    end

end
