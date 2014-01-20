class NotificationsController < ApplicationController
  def index
    @notifications = Notification.find_notifications current_user
  end
end
