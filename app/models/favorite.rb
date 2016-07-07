class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
  validates :user_id, :uniqueness => { :scope => :car_id }
end
