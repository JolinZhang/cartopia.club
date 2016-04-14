class Car < ActiveRecord::Base
  belongs_to :user
  validates :year,:make,:model,:mileage,:price,:contact,:city,:state, presence: true
  has_many :comments
  has_many :favorites
end
