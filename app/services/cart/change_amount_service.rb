class Cart::ChangeAmountService
  attr_reader :session, :product

  def initialize(session, product = {})
    @session = session
    @product = product
  end

  def call
    new_amount = [product[:balance], product[:amount]].min

    session[:products] = session[:products].merge(product[:id] => new_amount)
  end
end
