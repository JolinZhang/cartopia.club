class UsersController < ApplicationController
  def new
    @user = User.new()
  end
  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation))
		@user.isadmin = false
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  def show   
  end
  def managercar
    @cars = Car.all
  end
  def index
    @users = User.all
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  def update
    @user = User.find(params[:id])
    if params.require(:user).permit(:isadmin)["isadmin"].to_i == 0
      @user.update(isadmin: false)
    else
      @user.update(isadmin: true)
    end
    redirect_to users_path
  end
end
