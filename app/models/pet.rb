class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :adoption_applications
  has_many :pet_vaccinations
  has_many :vaccinations, through: :pet_vaccinations
  has_many_attached :photos
  has_many :pet_views

  default_scope { available.recent }

  scope :most_viewed, -> do
    joins('LEFT JOIN (SELECT pet_id, COUNT(*) as pet_count FROM pet_views GROUP BY pet_id) pet_counts ON pet_counts.pet_id = pets.id')
      .order(Arel.sql('COALESCE(pet_count, 0) DESC, pets.created_at DESC'))
  end

  scope :recent, -> { order("created_at DESC") }
  scope :available, -> { where(adoption_date: nil) }
  scope :search, ->(search) { where("name ILIKE :search OR breed ILIKE :search", { search: "%#{search}%" }) }

  scope :dogs, -> { where(pet_type: "dog") }
  scope :cats, -> { where(pet_type: "cat") }

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
    last_name = name.split(" ").last
    Pet.where("id != ?", id).where("name ILIKE ?", "%#{last_name}%").or(
      Pet.where("id != ?", id).where("name ILIKE ?", "%#{first_name}%")
    ).order("random()")
  end

  def tagline
    if pet_type == "dog"
      "#{name} is a #{age} year old #{breed} looking for a home!"
    else
      JSON.parse(Net::HTTP.get(URI("https://catfact.ninja/fact")))["fact"]
    end
  end

  def promo
    if pet_type == "dog"
      Net::HTTP.get(URI("http://localhost:3000/mock/slow-service"))
    else
      Net::HTTP.get(URI("http://localhost:3000/mock/outlier/#{id}"))
    end
  end
end
