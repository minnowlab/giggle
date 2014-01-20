class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  has_many :notification_relationships
end
