class MessagesController < ApplicationController
  load_and_authorize_resource only: [:edit, :update, :destroy]
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

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = "留言更新成功！"
      redirect_page = @message.messageable_type == "Evaluate" ?
                      product_evaluate_path(@product, @message.messageable) : 
                      product_path(@product)
      redirect_to redirect_page
    else
      flash.new[:danger] = "编辑失败，请重新编辑！"
      render 'edit'
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
        track_notification @message
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
      params.require(:message).permit(:content)
    end
end
