class Admin::BaseController < ApplicationController
  before_action :authorized_manage
  before_action :signed_in_user
  layout "admin"
  load_and_authorize_resource


  private
    def authorized_manage
      redirect_to root_path unless current_user.is?(:manager) || current_user.is?(:admin)
    end
end
