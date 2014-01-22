class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  def self.find_my_notifications current_user
    notes = Notification.where("user_id = ?", current_user.id).order("id desc")
    unread = notes.where(read: false)
    read = notes.where(read: true)
    notification = []
    notification = notification + unread + read
    unread.update_all(read: true)
    notification
  end

end
