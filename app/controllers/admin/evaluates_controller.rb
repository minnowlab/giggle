class Admin::EvaluatesController < Admin::BaseController
  before_action :find_evaluate, only: [:show, :edit, :update, :destroy, :create_message, :destroy_message]
  
  def index
    @evaluates = Evaluate.all.page(params[:page])
  end

  def show
    @message = @evaluate.messages.build
    @feed_items = @evaluate.feed
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
    if @evaluate.save
      redirect_to admin_evaluates_path
    else
      render 'new'
    end
  end
 
  def destroy
    @evaluate = Evaluate.find(params[:id])
    @evaluate.destroy
    redirect_to admin_evaluates_path
  end

  def create_message
    @message = @evaluate.messages.build(message_params)
    if @message.save
      redirect_to admin_evaluate_path(@evaluate)
    else
      @feed_items = @evaluate.feed.all
      render action: :show
    end
  end

  def destroy_message
    @message = Message.find(params[:message_id])
    @message.destroy
    redirect_to admin_evaluate_path(@evaluate)
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
