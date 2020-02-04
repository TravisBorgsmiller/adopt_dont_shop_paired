class ChangeAdoptableColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :adoptable, :status
  end
end
