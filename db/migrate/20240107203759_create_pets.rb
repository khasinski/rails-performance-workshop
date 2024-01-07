class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :vaccinations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :shelters do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
    end

    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.string :color
      t.decimal :weight
      t.integer :pet_type
      t.integer :gender
      t.integer :size
      t.string :microchip_number
      t.boolean :neutered, default: false
      t.boolean :house_trained, default: false
      t.boolean :special_needs, default: false
      t.boolean :suitable_for_apartments, default: false
      t.boolean :good_with_kids, default: false
      t.boolean :good_with_other_pets, default: false
      t.string :activity_level
      t.text :personality_traits
      t.text :medical_conditions
      t.text :allergies
      t.text :description
      t.text :biography
      t.date :date_of_birth
      t.date :arrival_date
      t.date :adoption_date
      t.references :shelter, foreign_key: true

      t.timestamps
    end

    create_table :adoption_applications do |t|
      t.string :applicant_name
      t.string :applicant_address
      t.string :applicant_phone
      t.string :applicant_email
      t.text :reason_for_adoption
      t.references :pet, foreign_key: true

      t.timestamps
    end

    create_table :pet_vaccinations do |t|
      t.references :pet, foreign_key: true
      t.references :vaccination, foreign_key: true
      t.date :vaccination_date

      t.timestamps
    end
  end
end
