class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation))
		@user.isadmin = false
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

end
