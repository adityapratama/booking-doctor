class Schedule < ApplicationRecord
  # enum day: [:sunday, :monday, :thuesday, :wednesday, :tuesday, :friday, :saturday]
  enum day: {sunday: 0, monday: 1, thuesday: 2, wednesday: 3, tuesday: 4, friday: 5, saturday: 6}

  belongs_to :doctor

  def doctor_name
    self.doctor.name
  end
end
