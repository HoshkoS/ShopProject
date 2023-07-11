class Cart::AddService
  attr_reader :session, :product

  def initialize(session, params = {})
    @session = session
    @product = params
  end

  def call
    if session[:products].key?(product[:id])
      input_amount = session.dig(:products, product[:id]) + product[:amount]
    else
      input_amount = product[:amount]
    end
    new_amount = [product[:balance], input_amount].min

    session[:products] = session[:products].merge(product[:id] => new_amount)
  end
end
