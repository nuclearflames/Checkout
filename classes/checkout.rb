require './classes/promo_code.rb'

class Checkout

  attr_reader :promo_codes, :items

  def initialize(promo_codes_list = nil)
    @promo_codes = []
    @items = []

    return if promo_codes_list.nil?

    promo_codes_list.each do |pc|
      @promo_codes.push(PromoCode.new(pc[0], pc[1]))
    end
  end


  def scan(item)
    item.price.gsub!(/[^0-9A-Za-z]/, '')

    @items.push(item)

    return({:code => item.code, :name => item.name, :price => item.price})
  end

  def total
    return currency_to_number(@items.map{|x|x.price.to_i}.inject(0, :+))
  end

  private

    # FYI this would normally be in a separate method (but we are only using it in the one class so no potential future duplication)
    def currency_to_number(number)
      "£" + number.to_s.insert(-3, ".")
    end

end