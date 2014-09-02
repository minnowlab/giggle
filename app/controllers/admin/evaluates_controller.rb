class Admin::EvaluatesController < Admin::BaseController
  before_action :find_evaluate, only: [:show, :edit, :update, :destroy, :create_message, :destroy_message]
  
  def index
    @evaluates = Evaluate.search(params)
  end

  def show
  end

  def edit
  end
 
  def update
    if @evaluate.update(evaluate_params)
      flash[:success] = '更新成功！'
      redirect_to admin_evaluates_path
    else
      flash.now[:danger] = '更新失败，请重新更新！'
      render 'edit'
    end
  end

  def new
    @evaluate = Evaluate.new
  end

  def create
    @evaluate = Evaluate.new(evaluate_params)
    @evaluate.user_id = current_user.id
    if @evaluate.save
      flash[:success] = '创建成功！'
      redirect_to admin_evaluates_path
    else
      flash.now[:danger] = '创建失败，请重新创建！'
      render 'new'
    end
  end
 
  def destroy
    @evaluate.destroy
    @evaluates = Evaluate.search(params)
    flash[:success] = '删除成功！'
    if @evaluates.blank?
      redirect_to admin_evaluates_path
    else
      redirect_to :back
    end
  end

  private
    
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details, :product_id)
    end
end
