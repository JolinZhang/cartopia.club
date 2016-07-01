class ApiController < ApplicationController
  def users
    if params[:id] != nil
      @users = User.where(id: params[:id])
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
      @user = @cars[0].user.username
      render :json => {"car" => @cars, "user_name" => @user}
    else
      @cars = Car.where(issold: false).order(created_at: :desc)
      render :json => @cars
    end
  end
# show all car and user's favs
def carsfavs
    @cars = Car.where(issold: false).order(created_at: :desc)
    myfav = []
    @cars.each do |car|
        myfav << car.as_json.merge(:isfav => car.favorites.select{|fav| fav.user_id == params[:user_id].to_i}.count >= 1)
    end
    render :json => myfav
end
# delete favs
def favsdestroy
  @user_id = params[:user_id]
  @car_id = params[:car_id]
  @fav = Favorite.where(car_id:  @car_id, user_id: @user_id)
  if @fav.destroy_all
    render :json =>{"success" => 2 }
  else
    render :json =>{"success" => 0 }
  end
end
# show info in favs
  def favs
    if params[:user_id] != nil
      @favs = Favorite.where(user_id: params[:user_id]).order(created_at: :desc)
      favcar = []
      @favs.each do |fav|
        @car = fav.car_id
        @car_info = Car.where(id: @car)
        @user = fav.user_id
        @user_name = User.where(id: @user)
        favcar << fav.as_json.merge(:user_name => @user_name[0].username, :car_info => @car_info[0] )
      end
      render :json => { "count" => @favs.count, "favs" => favcar}
    else
      @favs = Favorite.all.order(created_at: :desc)
      render :json => @favs
    end
  end
# create favs for a user and car
def createfavs
    @user_id = params[:user_id]
    @car_id = params[:car_id]
    @favorite = Favorite.new()
    @favorite.user_id = @user_id
    @favorite.car_id = @car_id
    if @favorite.save
      render :json =>{"success" => 1 }
    else
      render :json =>{"success" => 0 }
    end
end
# show comment of a car
  def comments
    if params[:car_id] != nil
      @comments = Comment.where(car_id: params[:car_id]).order(created_at: :desc)
      myhash = []
      @comments.each do |comment|
        @user = comment.user.username
        myhash << {"comments" => comment ,"user_name" => @user}
      end
      render :json => myhash
    else
      @comments = Comment.all
      render :json => @comments
    end
  end
# login for a user
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
# sign up for a user
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
# sort for cars
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
# create a car
  def create
    @year= params[:year]
    @make = params[:make]
		@model = params[:model]
    @mileage = params[:mileage]
    @price = params[:price]
    @contact = params[:contact]
    @city = params[:city]
    @state = params[:state]
    @notes = params[:notes]
    @user_id = params[:user_id]
    @car = Car.new()
    @car.year = @year
    @car.make = @make
    @car.model = @model
    @car.mileage = @mileage
    @car.price = @price
    @car.contact = @contact
    @car.city = @city
    @car.state = @state
    @car.notes = @notes
    @car.user_id = @user_id
		@car.issold = false
    @car.save
    if params[:picture].empty?
      @car.picture = 'default.jpg'
    else
      file_name = @car.user_id.to_s+"-"+@car.id.to_s+".jpg"
      File.open(Rails.root.join('app','assets','images','user_car',file_name), 'wb') do|f|
        f.write(Base64.decode64(params[:picture]))
      end
      @car.picture = file_name
    end
    @car.save
    render :json => @car
  end


end
