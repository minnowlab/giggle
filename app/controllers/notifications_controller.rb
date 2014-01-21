class NotificationsController < ApplicationController
  def index
    @notifications = Notification.find_my_notifications current_user
  end
end
