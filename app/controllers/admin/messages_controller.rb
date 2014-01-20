class Admin::MessagesController < Admin::BaseController
  before_action :find_message, only: [:show, :edit, :update, :destroy, :destroy_message]

  def index
    @messages = Message.message_search(params).paginate(page: params[:page])
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      flash[:success] = '创建成功！'
      redirect_to admin_messages_path 
    else
      flash.now[:danger] = '创建失败，请重新创建！'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = '更新成功！'
      redirect_to admin_messages_path
    else
      flash.now[:danger] = '更新失败，请重新更新！'
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    @messages = Message.paginate(page: params[:page])
    flash[:success] = '删除成功！'
    if @messages.blank?
      redirect_to admin_messages_path
    else
      redirect_to :back
    end
  end

  private
  
    def find_message
      @message = Message.find(params[:id])
    end
      
    def message_params
      params.require(:message).permit(:content, :product_id, :evaluate_id)
    end
end
