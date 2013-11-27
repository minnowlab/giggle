class Admin::MessagesController < Admin::BaseController
  before_action :find_message, only: [:show, :edit, :update, :destroy, :destroy_message]

  def index
    @messages = Message.sort(params[:sort]).page(params[:page])
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
       redirect_to admin_messages_path 
    else
       render 'new'
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to admin_messages_path
    else
       render 'edit'
    end
  end

  def destroy
    @message.destroy
    redirect_to admin_messages_path
  end


  private
  
    def find_message
      @message = Message.find(params[:id])
    end
      
    def message_params
      params.require(:message).permit(:content, :product_id, :user_id, :evaluate_id)
    end
end
