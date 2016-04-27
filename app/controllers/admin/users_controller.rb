class Admin::UsersController < ApplicationController

  before_filter :restrict_admin_access

  def index 
    @users = User.all.page params[:page]
  end

  def destroy
    
    @user = User.find(params[:id])
    UserMailer.goodbye_email(@user).deliver_later
    @user.destroy
    redirect_to admin_users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin)
  end

end
