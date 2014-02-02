class UsersController < ApplicationController

  before_action :find_user, except: :index
  layout "user"

  def index
    @users = User.select("id, name, email")
    render json: @users
  end

  def show
    @collections = @user.collections.order("id DESC")
  end

  def all_evaluates
    @evaluates = @user.evaluates.order("id DESC")
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
