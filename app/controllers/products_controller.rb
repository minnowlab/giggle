class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :create_message, :show_messages]
  before_action :find_message, only: [:destroy_message, :edit_message, :update_message]
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
    @product = @message.product
    @message.destroy
    flash[:success] = '删除成功！'
    redirect_to @product
  end

  def edit_message
  end

  def update_message
    if @message.update(message_update_params) 
      @product = @message.product
      flash[:success] = '修改成功！'
      redirect_to @product
    else
      flash.now[:danger] = '修改失败，请重新修改！'
      render 'edit_message'
    end
  end

  def show_messages
    @message = @product.messages.build
    @message_items = @product.feed.page(params[:page])
  end

  private

    def find_product
      @product = Product.find(params[:id])
    end

    def messages_params
      params.require(:message).permit(:content, :product_id)
    end

    def find_message
      @message = Message.find(params[:message_id])
    end

    def message_update_params
      params.require(:message).permit(:content)
    end
end
