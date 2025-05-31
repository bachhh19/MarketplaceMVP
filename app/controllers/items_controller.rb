class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    item = @cart.items.build(product: product)

    if item.save
      redirect_to cart_path, notice: 'Produit ajouté au panier.'
    else
      redirect_to product_path(product), alert: 'Impossible d’ajouter le produit.'
    end
  end

  def update
    item = @cart.items.find(params[:id])
    if item.update(item_params)
      redirect_to cart_path, notice: 'Article mis à jour.'
    else
      redirect_to cart_path, alert: 'Erreur lors de la mise à jour.'
    end
  end

  def destroy
    item = @cart.items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: 'Article retiré du panier.'
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def item_params
    params.require(:item).permit(:quantity)
  end
end
