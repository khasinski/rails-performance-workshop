class PetVaccination < ApplicationRecord
  belongs_to :pet
  belongs_to :vaccination
end