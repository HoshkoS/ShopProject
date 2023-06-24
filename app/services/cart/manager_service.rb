class Cart::ManagerService
  attr_reader :session, :params, :product, :product_balance
  attr_accessor :notice

  def initialize(session, params = {})
    @session = session
    @params = params
  end

  def call
    set_product

    case params[:update_action]

    when 'buy'
      Cart::AddService.new(session, product).call

    when 'change'
      Cart::ChangeAmountService.new(session, product).call

    when 'delete'
      Cart::RemoveService.new(session, product).call
    end
  end

  def items
    Product.find(session[:products].keys)
  end

  def sum
    items.map { |product| session[:products][product.id.to_s] * product.price }.sum
  end

  def product_sum(product)
    session.dig(:products, product.id.to_s) * product.price
  end

  private

  def set_product
    @product = {
      id: params[:id],
      amount: params[:amount].to_i
    }

    @product_balance = Product.find(product[:id]).balance

    product[:amount] = product_balance if product_balance < product[:amount]
  end
end
