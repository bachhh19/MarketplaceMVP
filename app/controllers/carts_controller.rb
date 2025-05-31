class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @cart = Cart.find(params[:id])
  end

  def create
    # déjà fait automatiquement par before_action si nécessaire
    redirect_to cart_path
  end

  def destroy
    @cart.items.destroy_all
    redirect_to cart_path, notice: 'Panier vidé avec succès.'
  end

  private

  def set_cart
    @cart = current_user.carts || current_user.create_cart
  end
end
