class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.belongs_to :clinic
      t.belongs_to :admin
      t.belongs_to :patient
      t.timestamps null: false
    end
    add_index :consultations, :clinic_id
    add_index :consultations, :admin_id
    add_index :consultations, :patient_id
  end
end
