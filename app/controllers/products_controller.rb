class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_seller!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def index
    if current_user&.seller?
      @products = Product.where(user_id: current_user.id)
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Produit créé avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Produit mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'Produit supprimé avec succès.'
  end

  private

  def only_seller!
    redirect_to root_path, alert: "Accès refusé." unless current_user&.seller?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :image_url, :description, :price)
  end
end
