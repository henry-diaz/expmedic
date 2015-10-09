class AddFieldsToClinicsTable < ActiveRecord::Migration
  def change
    add_column :clinics, :acronym, :string
    add_column :clinics, :accounts, :integer, default: 1
  end
end
