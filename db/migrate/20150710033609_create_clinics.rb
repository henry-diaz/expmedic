class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.text :address
      t.string :contact
      t.string :phone
      t.string :email
      t.attachment :logo
      t.timestamps null: false
    end
    add_index :clinics, :name
  end
end
