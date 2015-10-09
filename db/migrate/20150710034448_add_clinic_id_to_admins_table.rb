class AddClinicIdToAdminsTable < ActiveRecord::Migration
  def change
    add_column :admins, :clinic_id, :integer
    add_index :admins, :clinic_id
  end
end
