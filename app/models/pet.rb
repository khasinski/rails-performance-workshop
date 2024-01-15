class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :adoption_applications
  has_many :pet_vaccinations
  has_many :vaccinations, through: :pet_vaccinations
  has_many_attached :photos
  has_many :pet_views

  scope :most_viewed, -> do
    pet_ids = PetView.group(:pet_id).order('count_pet_id DESC').limit(12).count(:pet_id)
    relation = where(id: pet_ids.keys)
    relation = all.limit(12) if relation.empty?
    relation
  end

  enum pet_type: { dog: 0, cat: 1 }
  enum gender: { male: 0, female: 1, unknown: 2 }
  enum size: { small: 0, medium: 1, large: 2, extra_large: 3 }

  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :breed, presence: true
  validates :color, presence: true
  validates :weight, numericality: { greater_than: 0 }

  def image_url(width: 100, height: 100)
    if pet_type == "dog"
      "https://placedog.net/#{width}/#{height}?id=#{id % 230}"
    else
      "https://placekitten.com/#{width}/#{height}?image=#{id % 16}"
    end
  end

  def similar_type_pets
    Pet.where("id != ?", id).where(pet_type: pet_type).order("random()")
  end

  def similiar_name_pets
    first_name = name.split(" ").first
    Pet.where("id != ?", id).where("name ILIKE ?", "%#{first_name}%")
    last_name = name.split(" ").last
    Pet.where("id != ?", id).where("name ILIKE ?", "%#{last_name}%").or(
      Pet.where("id != ?", id).where("name ILIKE ?", "%#{first_name}%")
    ).order("random()")
  end
end
