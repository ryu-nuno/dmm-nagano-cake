class Item < ApplicationRecord

  has_many :cart_items
	has_many :order_items
	belongs_to :genre


	attachment :image
	
	enum is_active: {販売中:0,販売停止:1}


	validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
end
