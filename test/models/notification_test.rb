require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @unread_notification = notifications(:unread_christelle_notification)
    @read_notification = notifications(:read_christelle_notification)
    @user = users(:christelle)
  end

  test "should find current user notification" do
    assert_equal Notification.user_notification(@user), [@unread_notification, @read_notification]
  end

  test "should find all read notification" do
    assert_equal Notification.unread_scope, [@unread_notification]
  end

  test "should find all unread notification" do
    assert_equal Notification.read_scope, [@read_notification]
  end

  test "should find all notification" do
    assert_equal Notification.find_my_notifications(@user), [@unread_notification, @read_notification]
  end
end
