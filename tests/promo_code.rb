require './classes/promo_code.rb'

describe PromoCode do

  it "creates object" do
    expect(PromoCode.new).to have_attributes({})
  end

  it "can accept a new promo code" do
    expect(PromoCode.new("Buy2OrMore", "ProdCodeLH")).to have_attributes(rulename: "Buy2OrMore", product_code: "ProdCodeLH")
  end

  it "rejects invalid promo code" do
    expect(PromoCode.new("WrongCode", "ProdCodeLH").errors).to eq(["Invalid configuration added"])
  end

end