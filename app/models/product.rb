class Product < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, :price, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
