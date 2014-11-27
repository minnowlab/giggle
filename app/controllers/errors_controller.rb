class ErrorsController < ApplicationController
  after_action :destroy_database_connect
  
  def show
    render status_code.to_s, status: status_code
  end

  protected

  def status_code
    params[:code] || 500
  end

  def destroy_database_connect    
    ActiveRecord::Base.clear_active_connections!
  end
end
