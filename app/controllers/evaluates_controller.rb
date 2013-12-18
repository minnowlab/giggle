class EvaluatesController < ApplicationController
  before_action :find_evaluate, only: [:show, :edit, :update, :destroy]

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

  def destroy
    @evaluate.destroy
    flash[:success] = '删除成功！'
    redirect_to :back
  end

  def edit
    @product = Product.find(params[:product_id])
  end

  def update
    if @evaluate.update(evaluate_params)
      flash[:success] = '评测修改成功！'
      redirect_to product_evaluate_path(:product_id, @evaluate)
    else
      flash.now[:danger] = '修改失败，请重新修改！'
      render "edit"
    end
  end

  private
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details)
    end
end
