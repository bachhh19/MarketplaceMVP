class RenameStatutToStatusInCarts < ActiveRecord::Migration[7.1]
  def change
    rename_column :carts, :statut, :status
  end

end
