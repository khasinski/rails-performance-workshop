class Pet < ApplicationRecord
  geocoded_by :address

  belongs_to :shelter
  has_many :adoption_applications
  has_many :pet_vaccinations
  has_many :vaccinations, through: :pet_vaccinations
  has_many_attached :photos
  has_many :pet_views

  default_scope { available.recent }

  scope :most_viewed, -> do
    joins('LEFT JOIN (SELECT pet_id, COUNT(*) as pet_count FROM pet_views GROUP BY pet_id) pet_counts ON pet_counts.pet_id = pets.id')
      .reorder(Arel.sql('COALESCE(pet_count, 0) DESC, pets.created_at DESC'))
  end

  scope :recent, -> { order("created_at DESC") }
  scope :available, -> { where(adoption_date: nil) }
  scope :random, -> { order("RANDOM()") }
  scope :search, ->(search) { where("name ILIKE :search OR breed ILIKE :search", { search: "%#{search}%" }) }

  scope :dogs, -> { where(pet_type: "dog") }
  scope :cats, -> { where(pet_type: "cat") }
  scope :by_city, ->(city_name, distance) do
    city = BIGGEST_CITIES.find { |city| city[:name] == city_name }
    return none unless city
    near([city[:latitude], city[:longitude]], distance, unit: :km)
  end

  scope :random, -> { order("RANDOM()") }

  enum pet_type: { dog: 0, cat: 1 }
  enum gender: { male: 0, female: 1, unknown: 2 }
  enum size: { small: 0, medium: 1, large: 2, extra_large: 3 }

  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :breed, presence: true
  validates :color, presence: true
  validates :weight, numericality: { greater_than: 0 }

  def image_url(width: 100, height: 100)
    if dog?
      "https://placedog.net/#{width}/#{height}?id=#{(id || 0) % 230}"
    else
      "https://placekitten.com/#{width}/#{height}?image=#{(id || 0) % 16}"
    end
  end

  def similar_type_pets
    Pet.where.not(id: id).where(pet_type: pet_type).random
  end

  def similiar_name_pets
    first_name = name.split(" ").first
    last_name = name.split(" ").last
    Pet.where.not(id: id).where("name ILIKE ?", "%#{last_name}%").or(
      Pet.where.not(id: id).where("name ILIKE ?", "%#{first_name}%")
    ).random
  end

  def tagline
    if dog?
      "#{name} is a #{age} year old #{breed} looking for a home!"
    else
      JSON.parse(Net::HTTP.get(URI("https://catfact.ninja/fact")))["fact"]
    end
  end

  def promo
    if dog?
      Net::HTTP.get(URI("http://localhost:#{ENV["RAILS_PORT"]}/mock/slow-service"))
    else
      Net::HTTP.get(URI("http://localhost:#{ENV["RAILS_PORT"]}/mock/outlier/#{id}"))
    end
  end

  def dog?
    pet_type == "dog"
  end
end
