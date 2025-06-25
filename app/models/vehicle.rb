class Vehicle < ApplicationRecord
    belongs_to :user
    has_many :bookings, dependent: :destroy
    has_many_attached :photos, service: :cloudinary
    validates :title, :vehicle_type, :engine_size, :price_per_day, :location, :available_from, :available_to, presence: true
    validate :photo_count_validation
    validate :photo_format_and_size

    def photo_count_validation
        if photos.attached?
            errors.add(:photos, "maximum 5 images allowed") if photos.count > 5
        else
            errors.add(:photos, "must be attached")
        end
    end

    def photo_format_and_size
        return unless photos.attached?

        photos.each do |photo|
            if !photo.content_type.in?(%w[image/jpeg image /png])
                errors.add(:photos, "must be JPEG or PNG")
            end
            
            if photo.byte_size > 5.megabytes
                errors.add(:photos, "must be smaller than 5MB")
            end
        end
    end
end
