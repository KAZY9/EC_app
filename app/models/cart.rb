class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :product_id, :quantity, presence: true
  validates :quantity, numericality:{ only_integer: true }

  def sum_of_price
    product.taxin_price * quantity
  end  
end
