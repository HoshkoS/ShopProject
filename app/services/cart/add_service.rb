class Cart::AddService
  attr_reader :session, :product

  def initialize(session, params = {})
    @session = session
    @product = params
  end

  def call
    product[:amount] += session.dig(:products, product[:id]) if session[:products].key?(product[:id])

    new_amount = [product[:balance], product[:amount]].min

    session[:products] = session[:products].merge(product[:id] => new_amount)
  end
end
