class Item < ApplicationRecord

  # belongs_to :admin
  attachment :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  
end
