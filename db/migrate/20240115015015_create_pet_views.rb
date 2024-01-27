class CreatePetViews < ActiveRecord::Migration[6.1]
  def change
    create_table :pet_views do |t|
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
