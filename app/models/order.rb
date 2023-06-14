class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  def product_sum(product)
    product_orders.find_by(product:).amount * product.price
  end

  def product_amount(product)
    product_orders.find_by(product:).amount
  end

  def total_sum
    product_orders.map { |item| item.amount * Product.find(item.product_id).price }.sum
  end
end
