class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  has_many :notification_relationships

  def self.find_notifications current_user
    user_notifications = []
    current_user.evaluates do |evaluate|
      evaluate.messages do |message|
        user_notifications < message.notification
      end
    end
    user_notifications
  end

end
