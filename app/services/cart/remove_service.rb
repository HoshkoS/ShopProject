class Cart::RemoveService
  attr_reader :session, :product

  def initialize(session, product = {})
    @session = session
    @product = product
  end

  def call
    session[:products].delete(product[:id])
  end
end
