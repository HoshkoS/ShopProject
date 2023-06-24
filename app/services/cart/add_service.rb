class Cart::AddService
  attr_reader :session, :product, :product_balance

  def initialize(session, params = {})
    @session = session
    @product = params
  end

  def call
    if session[:products].key?(product[:id])
      amount = amount_greater_balance? ? product_balance: session[:products][product[:id]] + product[:amount]
      session[:products][product[:id]] = amount
    else
      @session[:products] = @session[:products].merge(product[:id] => product[:amount])
    end
    "Product was added to a cart"
  end

  private

  def amount_greater_balance?
    product_balance < (product[:amount] + session[:products][product[:id]])
  end
end
