class Cart::ManagerService
  attr_reader :session, :params

  def initialize(session, params = {})
    @session = session
    @params = params
  end

  def handle_update
    product = {
      id: params[:id],
      amount: params[:amount].to_i,
      balance: Product.find(params[:id]).balance
    }
    action = params[:update_action].classify

    service = "Cart::#{action}Service".constantize

    service.new(session, product).call
  end

  def get_realised_items
    Product.find(session[:products].keys)
  end

  def sum
    get_realised_items.sum { |product| product.price * session.dig(:products, product.id.to_s) }
  end

  def product_sum(product)
    session.dig(:products, product.id.to_s) * product.price
  end
end
