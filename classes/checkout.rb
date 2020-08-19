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
    @items.push(item)

    return({:code => item.code, :name => item.name, :price => item.price})
  end

  private

end