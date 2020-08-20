class PromoCode

  VALIDPROMOCODES = ["Buy2OrMore", "10percentoff"]

  attr_reader :rulename, :product_code, :errors

  def initialize(rulename = nil, product_code = nil)
    @errors = [] 

    if VALIDPROMOCODES.include?(rulename)
      @rulename = rulename
      @product_code = product_code
    else
      @errors.push("Invalid configuration added")
    end
  end

  private


end