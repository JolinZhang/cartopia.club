class SessionsController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
			log_in @user
      session[:user_id] = @user.id
			params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_path
    elsif !@user
      # Uername incorrect.
      @login_fail = 1
      render('new')
    elsif @user && !@user.authenticate(params[:session][:password])
      # Password incorrect.
      @login_fail = 2
      render('new')
    end
  end

  def destroy
    perform_logout if did_login?
    redirect_to root_path
  end

end
