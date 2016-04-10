class CarController < ApplicationController
	def list
		@cars= Car.all
	end
	def new
	
	end
end
