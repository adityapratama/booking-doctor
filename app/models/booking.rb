class Booking < ApplicationRecord
  validate :quota_availability, :max_time
  belongs_to :user
  belongs_to :doctor
  MAX_BOOKING_PER_DOCTOR = 10

  def quota_availability
    total_booking = Booking.where(doctor: doctor, start_date: self.start_date, end_date: self.end_date).count
    if total_booking >= MAX_BOOKING_PER_DOCTOR
      errors.add(:quota_availability, 'booking quota is excedeed')
    end
  end

  def max_time
    if Time.now > 30.minutes.until(self.start_date)
      errors.add(:max_time, 'Cannot booking max 30 minutes before schedule')
    end
  end
end
