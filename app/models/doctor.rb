class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :schedules
  
  def select_by(day)
    schedules.select {|s| s.day == day.strftime('%A').downcase}
  end

  def slug
    [id, name.parameterize].join('-')
  end
end
