class Products::DecreaseBalance
  def initialize(order)
    @order = order
  end

  def call
    @order.products.each do |product|
      new_balance = product.balance - @order.product_orders.find_by(product_id: product.id).amount
      product.update(balance: new_balance)
    end
  end
end
