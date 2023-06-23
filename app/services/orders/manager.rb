class Orders::Manager

  def initialize(products_hash, order, current_session)
    @products_hash = products_hash
    @order = order
    @current_session = current_session
  end

  def call
    @products_hash.each do |product_id, amount|
      product = Product.find(product_id)

      @order.product_orders.create(product_id:, amount:)
    end

    @order.products.each do |product|
      ActiveRecord::Base.connection.execute(
        "UPDATE products SET balance = balance - (
          SELECT amount
          FROM product_orders
          WHERE product_orders.order_id = #{@order.id}
          AND product_orders.product_id = #{product.id}
        )
        WHERE id = #{product.id};"
      )
    end

    @current_session.delete(:products)
  end
end
