require './classes/promo_code.rb'

class Checkout

  attr_reader :promo_codes

  def initialize(promo_codes_list = nil)
    @promo_codes = []

    return if promo_codes_list.nil?

    promo_codes_list.each do |pc|
      @promo_codes.push(PromoCode.new(pc[0], pc[1]))
    end
  end

  private

end