class NotificationPresenter < SimpleDelegator
  attr_reader :notification 

  def initialize(notification, view)
    super(view)
    @notification = notification
  end

  def dynamic_select
    notification.read ? "read" : "unread"
  end

  def render_notification
    div_for(notification, class: dynamic_select) do
      render_partial
    end
  end

  def render_partial
    locals = { notification: notification, message: notification.message }
    render partial_path, locals
  end

  def partial_path
    "notifications/notifications"
  end

end