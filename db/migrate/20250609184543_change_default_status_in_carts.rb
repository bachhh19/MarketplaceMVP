class ChangeDefaultStatusInCarts < ActiveRecord::Migration[7.0]
  def change
    change_column_default :carts, :status, 'new'
  end
end
