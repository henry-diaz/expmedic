class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.belongs_to :clinic
      t.belongs_to :patient
      t.text :pathological
      t.text :nonpathological
      t.text :family
      t.text :surgical
      t.text :allergies
      t.text :medicines
      t.float :weight
      t.float :size
      t.timestamps null: false
    end
    add_index :histories, :clinic_id
    add_index :histories, :patient_id
  end
end
