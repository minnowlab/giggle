class Admin::BaseController < ApplicationController
  before_action :signed_in_user
  layout "admin"
  load_and_authorize_resource
end
