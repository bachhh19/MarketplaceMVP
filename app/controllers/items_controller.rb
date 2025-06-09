class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    @cart = current_user.carts.find_by(status: "new")
    @cart ||= current_user.carts.create!(status: "new")

    product = Product.find_by(id: params[:product_id])

    if product.nil?
      redirect_back fallback_location: root_path, alert: "Produit introuvable."
      return
    end

    item = @cart.items.find_or_initialize_by(product: product)
    item.quantity = item.new_record? ? 1 : item.quantity + 1

    if item.save
      redirect_to cart_path, notice: 'Produit ajouté au panier.'
    else
      error_messages = item.errors.full_messages.join(', ')
      redirect_to product_path(product), alert: "Erreur : #{error_messages}"
    end
  end

  def update
    @item = Item.find(params[:id])

    unless @item.cart && @item.product
      redirect_to cart_path, alert: "Erreur : l'article est mal configuré."
      return
    end

    new_quantity = if params[:item].present? && params[:item][:quantity].present?
                     params[:item][:quantity].to_i
                   elsif params[:quantity].present?
                     params[:quantity].to_i
                   else
                     0
                   end

    if new_quantity < 1
      @item.destroy
    else
      if @item.update(quantity: new_quantity)
        flash[:notice] = "Quantité mise à jour."
      else
        flash[:alert] = @item.errors.full_messages.join(", ")
      end
    end

    redirect_to cart_path
  end

  def destroy
    item = @cart.items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: 'Article retiré du panier.'
  end

  private

  def set_cart
    @cart = current_user.current_cart
  end

  def item_params
    params.require(:item).permit(:quantity)
  end
end
