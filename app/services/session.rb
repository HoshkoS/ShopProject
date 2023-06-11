class Session
  def initialize(session)
    @session = session
  end

  def products
    @session[:products].keys.map { |id| Product.find(id) }
  end

  def sum
    products.map { |product| @session[:products][product.id.to_s] * product.price }.sum
  end

  def add_product(product)
    if @session[:products].has_key?(product.keys.first)
      @session[:products][product.keys.first] += product.values.first
    else
      @session[:products].merge!(product)
    end

    @session[:products]
  end

  def delete_product(product_id)
    @session[:products].delete(product_id)
    @session[:products]
  end
end
