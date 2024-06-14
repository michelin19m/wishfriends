class Item < ApplicationRecord
  belongs_to :wish_list
  has_many :bookings
  has_many_attached :images
end
