class SessionsController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
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
    perform_logout
    redirect_to root_path
  end

end
