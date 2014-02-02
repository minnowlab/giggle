class MessagesController < ApplicationController

  load_and_authorize_resource only: :destroy
  before_action :find_product

  def index
    @message = @product.messages.build
    @messages = @product.feed.paginate(page: params[:page])
  end

  def create
    @message = @product.messages.build(message_params.merge(user: current_user))
    @feed_count = @product.messages_count + 1
    respond_to do |format|
      if @message.save
        format.html { redirect_to :back }
        format.js
      else
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def destroy
    @feed_count = @message.messageable.messages_count - 1
    @message.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = "删除成功！"
        redirect_to :back
      }
      format.js
    end
    
  end

  def create_evaluate_message
    @evaluate = Evaluate.find(params[:evaluate_id])
    @message = @evaluate.messages.build(message_params.merge(user: current_user))
    @feed_count = @evaluate.messages_count + 1
    respond_to do |format|
      if @message.save
        @message.track_notification current_user
        format.html { redirect_to :back }
        format.js { render 'create'}
      else
        format.html { redirect_to :back }
        format.js { render 'create'}
      end
    end
  end

  private
    def find_product
      @product = Product.find(params[:product_id])
    end

    def find_message
      @message = @product.messages.find(params[:id])
    end

    def message_params
      message = params.require(:message).permit(:content)
      convert message if message[:content].include?("@")
      message
    end
end
