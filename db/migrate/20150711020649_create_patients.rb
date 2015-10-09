class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.belongs_to :clinic
      t.string :code
      t.string :firstname
      t.string :lastname
      t.date :birthdate
      t.string :gender
      t.string :civil_status
      t.string :email
      t.string :phone
      t.string :work_phone
      t.string :cellular
      t.string :fax
      t.text :address
      t.string :document_type
      t.string :document_number
      t.string :occupation
      t.string :education_level
      t.text :observations
      t.string :responsible
      t.attachment :photo
      t.timestamps null: false
    end
    add_index :patients, :clinic_id
    add_index :patients, :code
    add_index :patients, :firstname
    add_index :patients, :lastname
    add_index :patients, :phone
    add_index :patients, :email
    add_index :patients, :responsible
  end
end
