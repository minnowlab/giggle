class Admin::EvaluatesController < Admin::BaseController
  before_action :find_evaluates, only: [:show, :edit, :update, :destroy]
  def index
    @evaluates = Evaluate.all
  end

  def show
  end

  def edit
  end
 
  def update
    if @evaluate.update(evaluate_params)
      redirect_to admin_evaluate_path
    else
     render 'edit'
    end
  end

  def new
    @evaluate = Evaluate.new
  end

  def create
    @evaluate = Evaluate.new(evaluate_params)
    if @evaluate.save
      redirect_to admin_evaluates_path
    else
      render 'new'
    end
  end
 
  def destroy
    @evaluate.destroy
    redirect_to admin_evaluates_path
  end

  private
    
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details, :product_id, :user_id)
    end
end
