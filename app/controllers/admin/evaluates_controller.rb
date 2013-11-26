class Admin::EvaluatesController < Admin::BaseController
  before_action :find_evaluate, only: [:show, :edit, :update, :destroy, :create_message]
  def index
    @evaluates = Evaluate.all
  end

  def show
    @message = @evaluate.messages.build
  end

  def edit
  end
 
  def update
    if @evaluate.update(evaluate_params)
      redirect_to admin_evaluates_path
    else
     render 'edit'
    end
  end

  def new
    @evaluate = Evaluate.new
  end

  def create
    @evaluate = Evaluate.new(evaluate_params)
 #   @evaluate.user = current_user
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

  def create_message
    @message = @evaluate.messages.build(message_params)
    if @message.save
      redirect_to admin_evaluate_path(@evaluate)
    end
  end

  private
    
    def find_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    def evaluate_params
      params.require(:evaluate).permit(:title, :details, :product_id, :user_id)
    end

    def message_params
      params.require(:message).permit(:content, :user_id, :evaluate_id)
    end
end
