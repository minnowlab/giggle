class EvaluatesController < ApplicationController
  before_action :find_evaluate, only: [:show, :create_message]
  def index
  	@product = Product.find(params[:product_id])
    @evaluates = @product.evaluates
  end

  def show
    @message = @evaluate.messages.build
    @message_items = @evaluate.feed.page(params[:page])
    @product = @evaluate.product
  end

  def edit

  end

  def new

  end

  def update
  	
  end



  def create_message
    @message = @evaluate.messages.build(messages_params.merge(user: current_user))
    if @message.save
      flash[:success] = '评论成功！'
      redirect_to product_evaluate_path(:product_id, @evaluate)
    else
      @message_items = @evaluate.feed.page(params[:page])
      flash.now[:danger] = '评论失败,请重新评论!'
      render 'show'
    end
  end

  def destroy_message
    @message = Message.find(params[:message_id])
    @evaluate = @message.evaluate
    @message.destroy
    flash[:success] = "删除成功！"
    redirect_to product_evaluate_path(:product_id, @evaluate)
  end

  def edit_message
    
  end

  def update_message
    
  end

  private
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def messages_params
      params.require(:message).permit(:content, :evaluate_id, :product_id)
    end

end
