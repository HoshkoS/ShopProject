class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  scope :ordered, -> { order(last_name: :asc) }

  def full_name
    first_name.concat(" ", last_name)
  end

  def product_sum(product)
    ProductOrder.joins(:product).where(order_id: id, product_id: product.id).sum('product_orders.amount * products.price')
  end

  def product_amount(product)
    product_orders.find_by(product:).amount
  end

  def total_sum
    ProductOrder.joins(:product).where(order_id: id).sum('product_orders.amount * products.price')
  end
end
