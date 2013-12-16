class MessagesController < ApplicationController
  before_action :find_product
  before_action :find_message, only: [:edit, :update, :destroy]

  def index
    @message = @product.messages.build
    @messages = @product.feed.page(params[:page])
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = "编辑失败，请重新编辑！"
      redirect_page = @message.messageable_type == "Evaluate" ?
                      product_evaluate_path(@product, @message.messageable) : 
                      product_path(@product)
      redirect_to redirect_page
    else
      flash.new[:danger] = "编辑失败，请重新编辑！"
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    flash[:success] = "删除成功！"
    redirect_to :back
  end

  private
    def find_product
      @product = Product.find(params[:product_id])
    end

    def find_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:content)
    end
end
