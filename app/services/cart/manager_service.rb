class Cart::ManagerService
  attr_reader :session, :params
  attr_accessor :notice

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
    new_amount = [product[:balance], product[:amount]].min

    service = "Cart::#{params[:update_action].classify}Service".constantize

    service.new(session, product).call
  end

  def get_items
    Product.find(session[:products].keys)
  end

  def sum
    get_items.sum { |product| product.price * session.dig(:products, product.id.to_s) }
  end

  def product_sum(product)
    session.dig(:products, product.id.to_s) * product.price
  end
end
