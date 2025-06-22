class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Associations
  has_many :vehicles, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_one_attached :avatar

  validates :name, presence: true
end
