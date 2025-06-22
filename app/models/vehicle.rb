class Vehicle < ApplicationRecord
    belongs_to :user
    has_many :bookings, dependent: :destroy
    has_many_attached :photos
    validates :title, :vehicle_type, :engine_size, :price_per_day, :location, :available_from, :available_to, presence: true
end
