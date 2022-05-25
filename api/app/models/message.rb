class Message < ApplicationRecord
  has_many :likes
  belongs_to :user
  belongs_to :room
  validates :content, presence: true
end
