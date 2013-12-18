class EvaluatesController < ApplicationController
  before_action :find_evaluate, only: [:show, :edit, :update]
  before_action :find_product

  def index
    @evaluates = @product.evaluates
  end

  def show
    @message = @evaluate.messages.build
    @messages = @evaluate.feed.page(params[:page])
  end

  def new
    @evaluate = @product.evaluates.build
  end

  def create
    @evaluate = @product.evaluates.build(evaluate_params.merge(user: current_user))
    if @evaluate.save
      flash[:success] = '评测创建成功！'
      redirect_to product_evaluate_path(@product, @evaluate)
    else
      flash.now[:danger] = '创建失败，请重新创建！'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @evaluate.update(evaluate_params)
      flash[:success] = '评测编辑成功！'
      redirect_to product_evaluate_path(@product, @evaluate)
    else
      flash.now[:danger] = '编辑失败，请重新创建！'
      render 'edit'
    end
  end

  private
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def find_product
      @product = Product.find(params[:product_id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details)
    end
end
