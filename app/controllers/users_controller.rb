class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit]
  def index
  	@user = User.page(params[:page])
  end

  def show

  end

  def edit
  	
  end

  private
    def find_user
      @user = User.find(params[:id])
    end
end
