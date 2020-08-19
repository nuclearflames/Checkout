class Item

  attr_accessor :code, :name, :price, :promo_price

  def initialize(code = nil, name = nil, price = nil)

    @code = code
    @name = name
    @price = price
    @promo_price = price

  end

  private


end