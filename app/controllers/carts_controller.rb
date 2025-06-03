class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def index
    if current_user.seller?
      @carts = Cart.joins(:items => :product)
                  .where(products: { user_id: current_user.id }, status: "commande")
                  .distinct
    else
      @carts = current_user.carts.where(status: "commande")
    end
  end

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def create
    redirect_to cart_path
  end

  def destroy
    @cart.items.destroy_all
    redirect_to cart_path, notice: 'Panier vidé avec succès.'
  end

  def update
    if @cart.update(cart_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @carts, notice: "Panier mis à jour avec succès." }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:status)
  end

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
