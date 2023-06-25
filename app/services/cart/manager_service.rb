class Cart::ManagerService
  attr_reader :session, :params
  attr_accessor :notice

  def initialize(session, params = {})
    @session = session
    @params = params
  end

  def call
    product = {
      id: params[:id],
      amount: params[:amount].to_i,
      balance: Product.find(params[:id]).balance
    }

    product[:amount] = product[:balance] if product[:balance] < product[:amount]

    service = "Cart::#{params[:update_action].classify}Service".constantize

    service.new(session, product).call

    "Product #{params[:update_action]} in cart"
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
