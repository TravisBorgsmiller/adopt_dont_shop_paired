class RemovePendingColumnFromPetApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :pet_applications, :pending, :string, default: 'false'
  end
end
