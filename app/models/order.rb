class Order < ApplicationRecord
  scope :ordered, -> { order(last_name: :asc) }

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  def product_sum(product)
    ActiveRecord::Base.connection.execute(
      "SELECT product_orders.amount * products.price AS product_sum
      FROM product_orders
      JOIN products ON products.id = product_orders.product_id
      WHERE product_orders.order_id = #{id}
      AND product_orders.product_id = #{product.id};"
    )
  end

  def product_amount(product)
    product_orders.find_by(product:).amount
  end

  def total_sum
    ActiveRecord::Base.connection.execute(
      "SELECT SUM(product_orders.amount * products.price) AS total_sum
      FROM product_orders
      JOIN products ON products.id = product_orders.product_id
      WHERE product_orders.order_id = #{id};"
    )
  end
end
