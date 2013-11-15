class Admin::BaseController < ApplicationController
  before_action :signed_in_user
  layout "admin"
end
