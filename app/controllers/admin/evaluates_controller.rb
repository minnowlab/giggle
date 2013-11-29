class Admin::EvaluatesController < Admin::BaseController
  before_action :find_evaluate, only: [:show, :edit, :update, :destroy, :create_message, :destroy_message]
  
  def index
    @evaluates = Evaluate.page(params[:page])
  end

  def show
    @message = @evaluate.messages.build
    @feed_items = @evaluate.feed
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
    @evaluates = Evaluate.page(params[:page])
    flash[:success] = '删除成功！'
    if @evaluates.blank?
      redirect_to admin_evaluates_path
    else
      redirect_to :back
    end
  end

  def create_message
    @message = @evaluate.messages.build(message_params)
    if @message.save
      flash[:success] = '创建成功！'
      redirect_to :back
    else
      @feed_items = @evaluate.feed.all
      flash.now[:danger] = '创建失败，请重新创建！'
      render action: :show
    end
  end

  def destroy_message
    @message = Message.find(params[:message_id])
    @message.destroy
    flash[:success] = '删除成功！'
    redirect_to :back
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
