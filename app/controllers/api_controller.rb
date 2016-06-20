class ApiController < ApplicationController
  def users
    if params[:id] != nil
      @users = User.where(id: params[:id]).order(created_at: :desc)
      render :json => @users
    else
    	@users = User.all.order(created_at: :desc)
      render :json => @users
    end
  end

  def cars
    if params[:user_id] != nil
      @cars = Car.where(user_id: params[:user_id]).order(created_at: :desc)
      render :json => @cars
    elsif  params[:id] != nil
      @cars = Car.where(id: params[:id])
      render :json => @cars
    else
      @cars = Car.where(issold: false).order(created_at: :desc)
      render :json => @cars
    end
  end

  def favs
    if params[:user_id] != nil
      @favs = Favorite.where(user_id: params[:user_id]).order(created_at: :desc)
      render :json => @favs
    else
      @favs = Favorite.all.order(created_at: :desc)
      render :json => @favs
    end
  end

  def comments
    if params[:car_id] != nil
      @comments = Comment.where(car_id: params[:car_id]).order(created_at: :desc)
      render :json => @comments
    else
      @comments = Comment.all
      render :json => @comments
    end
  end

	def login
		@username = params[:username]
		@password = params[:password]

    @user = User.find_by(username: @username.downcase)
    if @user && @user.authenticate(@password)
			render :json => {"success" => 1, "id" => @user.id}
		else
			render :json => {"success" => 0}
		end
	end

  def signup
    @username = params[:username]
    @email = params[:email]
		@password = params[:password]
    @password_confirmation = params[:password_confirmation]
    @user = User.new()
    @user.username = @username
    @user.email = @email
    @user.password = @password
    @user.password_confirmation = @password_confirmation
    @user.isadmin = false
    if @user.save
      render :json =>{"success" => 1, "id" => @user.id }
    else
      render :json =>{"success" => 0 }
    end
  end

  def sort
    @sort = params[:sort]
    case @sort
			when '0'
				@cars = Car.where(issold: false).order(:created_at)
        render :json => @cars
      when '1'
	      @cars = Car.where(issold: false).order(created_at: :desc)
        render :json => @cars
      when '2'
        @cars = Car.where(issold: false).order(:price)
        render :json => @cars
      when '3'
			  @cars = Car.where(issold: false).order(price: :desc)
        render :json => @cars
      when '4'
        @cars = Car.where(issold: false).order(:mileage)
        render :json => @cars
			when '5'
				@cars = Car.where(issold: false).order(mileage: :desc)
        render :json => @cars
      when '6'
        @cars = Car.where(issold: false).order(:year)
        render :json => @cars
			when '7'
				@cars = Car.where(issold: false).order(year: :desc)
        render :json => @cars
			else
				@cars = Car.where(issold: false).order(created_at: :desc)
        render :json => @cars
		end
  end

end
