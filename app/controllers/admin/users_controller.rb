class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def index 
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end


end
