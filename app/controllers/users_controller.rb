class UsersController < ApplicationController
  before_action :find_user, except: :index
  layout "user"

  def index
    @users = User.all.paginate(page: params[:page])
  end

  def show_evaluates
    @evaluates = @user.evaluates.order("id DESC")
  end

  def show_collections
    @collections = @user.collections.order("id DESC")
  end

  def show
    @evaluates = @user.evaluates.limit(8)
    @collections = @user.collections.order("id DESC").limit(8)
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
