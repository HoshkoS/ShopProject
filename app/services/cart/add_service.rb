class Cart::AddService
  attr_reader :session, :product

  def initialize(session, params = {})
    @session = session
    @product = params
  end

  def call
    if session[:products].key?(product[:id])
      amount = session.dig(:products, product[:id]) + product[:amount]

      session[:products][product[:id]] = [product[:balance], amount].min
    else
      @session[:products] = @session[:products].merge(product[:id] => product[:amount])
    end
  end
end
