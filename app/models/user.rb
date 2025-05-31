class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :carts, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :firstname, :lastname, :role, presence: true

  enum role: {
    buyer: 'buyer',
    seller: 'seller'
  }

  after_initialize do
    self.role ||= :buyer if self.new_record?
  end

end
