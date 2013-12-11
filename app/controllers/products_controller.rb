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
  	@message = @product.messages.build(messages_params)
    if @message.save
      flash[:success] = '评论成功！'
      redirect_to @product
    else
      @evaluates = @product.evaluates.order("created_at desc").limit(5)
      @message_items = @product.feed.page(params[:page])
      flash.now[:danger] = '评论失败,请重新评论！'
      render 'show'
    end
  end

  def destroy_message
    @message = Message.find(params[:message_id])
    @product = @message.product
    @message.destroy
    flash[:success] = '删除成功！'
    redirect_to @product
    
  end

  private

    def find_product
      @product = Product.find(params[:id])
    end

    def messages_params
      params.require(:message).permit(:content, :user_id, :product_id)
      
    end

end
