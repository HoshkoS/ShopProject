class Orders::ManagerService

  def initialize(cart, order, current_session)
    @cart = cart
    @order = order
    @current_session = current_session
  end

  def call
    create_product_relations

    decrease_product_balance

    clean_cart
  end

  private

  def create_product_relations
    product_orders = @cart.map do |product_id, amount|
      { product_id: product_id.to_i, amount: amount, order_id: @order.id }
    end

    ProductOrder.insert_all(product_orders)
  end

  def decrease_product_balance
    @order.products.each do |product|
      product.update(balance: product.balance - product.product_orders.where(order_id: @order.id).sum(:amount))
    end
  end

  def clean_cart
    @current_session.delete(:products)
  end
end
