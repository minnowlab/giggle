class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, danger: exception.message
  end

  def convert content 
      message = content[:content]
      users = message.scan(/@([\w\u4e00-\u9fa5]{2,20})/).flatten
      users = User.where(name: users)
      users.each do |user|
        url = "[@#{user.name}](/users/#{user.id})"
        message = message.gsub!(/(@#{user.name})/, url) 
      end
  end
end
