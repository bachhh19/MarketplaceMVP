class Cart < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  def total_price
    items.includes(:product).sum { |item| (item.quantity || 0) * item.product.price }
  end

  def total_items_count
    items.sum { |item| item.quantity.to_i }
  end
end
