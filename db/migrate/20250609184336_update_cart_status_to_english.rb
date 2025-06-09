class UpdateCartStatusToEnglish < ActiveRecord::Migration[7.0]
  def up
    Cart.where(status: 'nouveau').update_all(status: 'new')
    Cart.where(status: 'commande').update_all(status: 'confirmed')
    Cart.where(status: 'livre').update_all(status: 'delivered')
  end

  def down
    Cart.where(status: 'new').update_all(status: 'nouveau')
    Cart.where(status: 'confirmed').update_all(status: 'commande')
    Cart.where(status: 'delivered').update_all(status: 'livre')
  end
end
