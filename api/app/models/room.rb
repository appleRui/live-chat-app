class Room < ApplicationRecord
  has_many :messages
  has_many :users, through: :room_user
  has_many :room_users
  accepts_nested_attributes_for :room_users
end
