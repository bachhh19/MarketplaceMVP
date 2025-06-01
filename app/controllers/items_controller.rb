class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  def create
    product = Product.find(params[:product_id])
    item = @cart.items.find_by(product_id: product.id)


    if item
      item.quantity = (item.quantity || 0) + 1
    else
      item = @cart.items.build(product: product, quantity: 1)
    end

    if item.save
      redirect_to cart_path, notice: 'Produit ajouté au panier.'
    else
      redirect_to product_path(product), alert: 'Impossible d’ajouter le produit.'
    end
  end

  def update
    @item = Item.find(params[:id])

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
      @item.update(quantity: new_quantity)
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
    @cart = current_user.cart || current_user.create_cart
  end

  def item_params
    params.require(:item).permit(:quantity)
  end
end
