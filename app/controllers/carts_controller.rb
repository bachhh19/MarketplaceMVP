class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    @cart = current_user.cart || current_user.create_cart
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
    @cart = current_user.cart || current_user.create_cart
  end
end
