class NotificationsController < ApplicationController
  def index
    @notifications = Notification.find_my_notifications current_user
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    flash[:success] = "删除成功！"
    redirect_to :back
  end
end
