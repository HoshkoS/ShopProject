class Orders::CreateProductOrders
  def initialize(products_hash, order)
    @products_hash = products_hash
    @order = order
  end

  def call
    @products_hash.each do |product_id, amount|
      product = Product.find(product_id)
      amount = amount < product.balance ? amount : product.balance

      @order.product_orders.create(product_id:, amount:)
    end
  end
end
