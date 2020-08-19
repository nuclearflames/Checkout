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
    return currency_to_number(manipulate_price)
  end

  private

    # FYI this would normally be in a separate class (but we are only using it in the one class so no potential future duplication)
    def currency_to_number(number = nil)
      "£" + number.to_s.insert(-3, ".")
    end

    def manipulate_price

      final_price = 0

      @promo_codes.each do |promo_code|
        case promo_code.rulename
        when "Buy2OrMore"
          lavender_heart_products = @items.select{|x| x.name == "Lavender heart" && x.code == promo_code.product_code }

          if lavender_heart_products.size > 1
            final_price += lavender_heart_products.map do |x|
              x.price.to_i - 75
            end.inject(0, :+)
          end 
        end
      end

      return final_price

    end

end