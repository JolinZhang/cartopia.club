class UsersController < ApplicationController
  def new
		if did_login?
			redirect_to user_cars_path(current_user)
		else 
			@user = User.new()
		end
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
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
	def favs 
		@favs = current_user.favorites.order(created_at: :desc)
		@cars = @favs.collect {|fav| fav.car}
	end
	def cars
		@cars = current_user.cars.order(created_at: :desc)
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
