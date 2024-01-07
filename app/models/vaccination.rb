class Vaccination < ApplicationRecord
  has_many :pet_vaccinations
  has_many :pets, through: :pet_vaccinations

  validates :name, presence: true
end
