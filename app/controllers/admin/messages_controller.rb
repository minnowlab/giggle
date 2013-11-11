class Admin::MessagesController < ApplicationController
  layout "admin"
  before_action :signed_in_admin

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
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
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])

      if @message.update(message_params)
        redirect_to admin_messages_path
      else
         render 'edit'
      end
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to admin_messages_path
  end

  private
    
    def message_params
      params.require(:message).permit(:content, :product_id)
    end
end
