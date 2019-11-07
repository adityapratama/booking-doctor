class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    random_string = SecureRandom.hex
    create! do |user|
      user.email = auth.info.email || "#{random_string}@booking-doctor.com"
      user.password = random_string
      user.password_confirmation = random_string
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end
end
