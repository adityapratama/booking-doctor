class Hospital < ApplicationRecord
  has_many :doctors
  belongs_to :city

  class << self
    def search(keyword)
      where("LOWER(name) LIKE '%#{keyword.downcase}%'")
    end
  end

  def slug
    [id, name.parameterize].join('-')
  end
end
