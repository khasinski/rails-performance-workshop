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

  def image_url
    if pet_type == "dog"
      "https://placedog.net/100/100?id=#{id % 230}"
    else
      "https://placekitten.com/100/100?image=#{id % 16}"
    end
  end
end
