class Car < ActiveRecord::Base
  belongs_to :user
  validates :year,:make,:model,:mileage,:price,:contact,:city,:state, presence: true
  validates :model, format:  {with: /\A[a-zA-Z]+\z/, message:"only allows letters" }
  validates :price, numericality: {only_integer: true}
  validates :city, format: {with: /\A[a-zA-Z]+\z/, message:"only allows letters"}
  validates  :state, format: {with:/\A[a-zA-Z]+\z/, message:"only allows letters"}
  has_many :comments,  :dependent => :delete_all
  has_many :favorites, :dependent => :delete_all
end

