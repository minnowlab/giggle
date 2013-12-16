class EvaluatesController < ApplicationController
  before_action :find_evaluate, only: [:show, :create_message]

  def index
  	@product = Product.find(params[:product_id])
    @evaluates = @product.evaluates
  end

  def show
    @message = @evaluate.messages.build
    @messages = @evaluate.feed.page(params[:page])
    @product = @evaluate.product
  end

  def edit
  end

  def new
    @product = Product.find(params[:product_id])
    @evaluate = @product.evaluates.build
  end

  def create
    @product = Product.find(params[:product_id])
    @evaluate = @product.evaluates.build(evaluate_params.merge(user: current_user))
    if @evaluate.save
      flash[:success] = '评测创建成功！'
      redirect_to product_evaluate_path(:product_id, @evaluate)
    else
      flash.now[:danger] = '创建失败，请重新创建！'
      render 'new'
    end
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

  private
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details)
    end

    def messages_params
      params.require(:message).permit(:content, :evaluate_id, :product_id)
    end

end
