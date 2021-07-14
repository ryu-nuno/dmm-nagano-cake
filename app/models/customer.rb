class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         
  has_many :cart_items
  has_many :addresses
  has_many :orders
  
  enum withdrawal_status: { 有効: 0, 無効: 1 }
  
  
end
