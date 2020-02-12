class AddPendingForToPet < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :pending_for, :string, default: 'none'
  end
end
