class EvaluatesController < ApplicationController
  before_action :find_evaluate, only: [:show, :create_message]
  def index
  	@product = Product.find(params[:product_id])
    @evaluates = @product.evaluates
  end

  def show
    @message = Message.new
    @message_items = @evaluate.messages
  end

  def edit

  end

  def new

  end

  def update
  	
  end

  def create
  	
  end

  def destroy
  	
  end

  def create_message
    @message = @evaluate.messages.build(messages_params)
    if @message.save
      flash[:success] = '评论成功！'
      redirect_to :back
    else
      @message = Message.new
      @message_items = @evaluate.messages
      flash.now[:danger] = '评论失败,请重新评论!'
      render 'show'
    end
  end

  private
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def messages_params
      params.require(:message).permit(:content, :user_id, :evaluate_id)
    end

end
