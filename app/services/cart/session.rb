class Cart::Session
  attr_reader :session, :params, :product, :product_balance
  attr_accessor :notice

  def initialize(session, params = {})
    @session = session
    @params = params
  end

  def call
    case params[:update_action]

    when 'buy'
      add_product
      "Product added to cart."

    when 'change'
      change_amount
      "Amount was changed"

    when 'delete'
      delete_product
      "Product was removed"
    end
  end

  def items
    Product.find(session[:products].keys)
  end

  def sum
    items.map { |product| session[:products][product.id.to_s] * product.price }.sum
  end

  def session_product_sum(product)
    session.dig(:products, product.id.to_s) * product.price
  end
  private

  def add_product
    set_product

    if session[:products].key?(product[:id])
      amount = amount_greater_balance? ? product_balance: session[:products][product[:id]] + product[:amount]
      session[:products][product[:id]] = amount
    else
      @session[:products].merge!(product[:id] => product[:amount])
    end
  end

  def change_amount
    set_product

    session[:products][product[:id]] = product[:amount]
  end

  def delete_product
    session[:products].delete(params[:id])
  end

  def set_product
    @product = {
      id: params[:id],
      amount: params[:amount].to_i
    }

    @product_balance = Product.find(product[:id].to_i).balance

    product[:amount] = product_balance if product_balance < product[:amount]
  end

  def amount_greater_balance?
    product_balance < (product[:amount] + session[:products][product[:id]])
  end
end
