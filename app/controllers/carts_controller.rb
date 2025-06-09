class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def index
    if current_user.seller?
      @carts = Cart.joins(items: :product)
                  .where(products: { user_id: current_user.id }, status: ["confirmed", "delivered"])
                  .distinct
    else
      @carts = current_user.carts.where(status: ["confirmed", "delivered"])
    end
  end

  def show
    @cart = current_user.current_cart
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
      if @cart.status == "confirmed"
        Cart.create(user: current_user, status: "new")
      end
      redirect_to carts_path, notice: "Panier commandé avec succès. Un nouveau panier est prêt."
    else
      flash[:alert] = @cart.errors.full_messages.join(", ")
      redirect_to carts_path
    end
  end

  def mark_as_delivered
    @cart = Cart.find(params[:id])
    if current_user.seller? && @cart.items.joins(:product).where(products: { user_id: current_user.id }).exists?
      @cart.update(status: "delivered")
      redirect_back fallback_location: carts_path, notice: "Le panier ##{@cart.id} a été marqué comme livré."
    else
      redirect_back fallback_location: carts_path, alert: "Vous ne pouvez pas modifier ce panier."
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:status)
  end

  def set_cart
    @cart = current_user.carts.find_by(status: "new") || current_user.carts.create(status: "new")
  end
end
