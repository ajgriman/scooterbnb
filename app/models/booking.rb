class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  after_initialize :set_default_status, if: :new_record?

  validates :start_date, :end_date, presence: true
  validate :start_date_before_end_date

  private

  def set_default_status
    self.status ||= 'pending'
  end

  def start_date_before_end_date
    return unless start_date && end_date
    errors.add(:start_date, 'must be before end date') if start_date >= end_date
  end
end
