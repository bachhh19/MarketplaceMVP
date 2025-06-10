class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :carts, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :firstname, :lastname, :role, presence: true

  after_create :create_cart_if_buyer

  def create_cart_if_buyer
    if buyer? && carts.where(status: 'new').empty?
      carts.create(status: 'new')
    end
  end

  enum role: {
    buyer: 'buyer',
    seller: 'seller'
  }

  after_initialize do
    self.role ||= :buyer if self.new_record?
  end

  def current_cart
    carts.find_or_create_by(status: 'new')
  end

  def current_role
    return "Acheteur" if self.role.capitalize == "Buyer"
    return "Vendeur" if self.role.capitalize == "Seller"
  end
end
