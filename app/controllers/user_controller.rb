class UserController < ApplicationController
  def login
  end

	def signup
	end

	def create
		@user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation))
		if @user.save 
			redirect_to root_path
		else 
			render 'signup'
		end
	end

end
