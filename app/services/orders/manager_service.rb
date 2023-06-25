class Orders::ManagerService

  def initialize(products_hash, order, current_session)
    @products_hash = products_hash
    @order = order
    @current_session = current_session
  end

  def call
    product_orders = @products_hash.map do |product_id, amount|
      { product_id: product_id.to_i, amount: amount, order_id: @order.id }
    end

    ProductOrder.insert_all(product_orders)

    @order.products.each do |product|
      Product.where(id: product.id).update_all(
        "balance = balance - (
          SELECT amount
          FROM product_orders
          WHERE product_orders.order_id = #{@order.id}
          AND product_orders.product_id = #{product.id}
        )"
      )
    end

    @current_session.delete(:products)
  end
end
