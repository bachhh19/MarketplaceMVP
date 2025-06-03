class AddStatutToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :statut, :string, default: "nouveau"
  end
end
