class NotificationPresenter < SimpleDelegator
  attr_reader :notification 

  def initialize(notification, view)
    super(view)
    @notification = notification
  end

  def render_notification
    div_for notification do
      link_to(notification.user.name, notification.user) + " " + render_partial
    end
  end

  def render_partial
    locals = { notification: notification, presenter: self }
    locals[notification.trackable_type.underscore.to_sym] = notification.trackable
    render partial_path, locals
  end

  def partial_path
    "notifications/#{notification.trackable_type.underscore}/#{notification.action}"
  end