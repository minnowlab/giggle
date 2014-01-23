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
    locals[:describe] = self.select_describe
    render partial_path, locals
  end

  def partial_path
    "notifications/notifications"
  end

  def select_describe
    if notification.message
      evaluate = notification.message.messageable
      if notification.message.inc_user.include?(current_user)
        "在回复时提到了你"
      elsif notification.user == evaluate.user
        "回复你的评测"
      else
        "回复你关注的评测"
      end
    end 
  end

end