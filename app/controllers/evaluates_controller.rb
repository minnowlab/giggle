class EvaluatesController < ApplicationController
  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy]
  before_action :find_product
  before_action :find_evaluate, only: [:show, :edit, :update, :destroy]
  
  def index
    @evaluates = @product.evaluates
  end

  def show
    @message = @evaluate.messages.build
    @messages = @evaluate.feed.paginate(page: params[:page], per_page: Message.per_page)
    @likeable = Likeship.likeable(@evaluate)
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
    @product = Product.find(params[:product_id])
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

  def destroy
    @evaluate.destroy
    flash[:success] = '删除成功！'
    redirect_to :back 
  end

  private
    def find_evaluate
      @evaluate = @product.evaluates.find(params[:id])
    end

    def find_product
      @product = Product.find(params[:product_id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details)
    end

end
