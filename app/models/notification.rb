class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  def self.find_my_notifications current_user
    notifications = Notification.all
    notifications = notifications.where("user_id = ?", current_user.id)
    notifications
  end

end
