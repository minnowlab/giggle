class Admin::MessagesController < Admin::BaseController
  before_action :find_message, only: [:edit, :update, :destroy]

  def index
    @messages = Message.message_search(params)
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
    @messages = Message.message_search(params)
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
