class EvaluatesController < ApplicationController
  before_action :find_evaluate, only: [:show, :edit, :update]

  def index
  	@product = Product.find(params[:product_id])
    @evaluates = @product.evaluates
  end

  def show
    @message = @evaluate.messages.build
    @messages = @evaluate.feed.page(params[:page])
    @product = @evaluate.product
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

  def edit
  end

  def update
  end

  private
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details)
    end
end
