require './classes/promo_code.rb'

class Checkout

  attr_reader :promo_codes, :items

  def initialize(promo_codes_list = nil)
    @promo_codes = []
    @items = []

    return if promo_codes_list.nil?

    promo_codes_list.sort_by! {|x|x.size}.reverse!

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
    manipulate_prices

    final_price = @items.map do |x|
      x.promo_price.to_f
    end.inject(0, :+).round

    return currency_to_number(final_price)
  end

  private

    # FYI this would normally be in a separate class (but we are only using it in the one class so no potential future duplication)
    def currency_to_number(number = nil)
      "£" + number.to_s.insert(-3, ".")
    end

    def manipulate_prices

      @promo_codes.each do |promo_code|
        case promo_code.rulename
        when "Buy2OrMore"
          lavender_heart_products = @items.select{|x| x.name == "Lavender heart" && x.code == promo_code.product_code }

          if lavender_heart_products.size > 1
            lavender_heart_products.each do |x|
              x.promo_price = x.promo_price.to_f - 75
            end
          end
        when "10percentoff"
          if @items.map { |x| x.promo_price.to_f }.inject(0, :+) >= 6000
            @items.each do |x|
              x.promo_price = x.promo_price.to_f * 0.9
            end
          end
        end
      end

      return true

    end

end