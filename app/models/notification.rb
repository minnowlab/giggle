class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :message

  scope :user_notification, ->(user) { where(user: user) }
  scope :unread_scope, -> { where(read: false) }
  scope :read_scope, -> { where(read: true) }

  def self.find_my_notifications current_user
    notes = self.user_notification(current_user).order("id desc")
    unread = notes.unread_scope
    read = notes.read_scope
    notification = []
    notification += unread + read
    unread.update_all(read: true)
    notification
  end

end
