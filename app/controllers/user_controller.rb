class UserController < ApplicationController
  def login_form
		@user = User.new()
  end

	def login
		@user = User.find_by(username: params[:user][:username].downcase)
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to root_path
		elsif !@user
			# Uername incorrect.
			@login_fail = 1
			render('login_form')
		elsif @user && !@user.authenticate(params[:user][:password])
			# Password incorrect.
			@login_fail = 2
			render('login_form')
		end
	end

	def signup_form
		@user = User.new()
	end

	def signup
		@user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation))
		@user.isadmin = false
		if @user.save 
			redirect_to root_path
		else 
			render 'signup_form'
		end
	end

	def logout
		perform_logout
		redirect_to root_path
	end

end
