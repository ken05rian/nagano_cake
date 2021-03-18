class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  accepts_nested_attributes_for :order_details
  enum payment_method: {クレジットカード:1, 銀行振込:2}
  enum status: {入金待ち:0, 入金確認:1, 製作中:2, 発送待ち:3, 発送済み:4}

end

