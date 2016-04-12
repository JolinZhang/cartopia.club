class Car < ActiveRecord::Base
  belongs_to :user
  validates :year,:make,:model,:mileage,:price,:contact,:city,:state, presence: true
end
