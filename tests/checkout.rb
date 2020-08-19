require './classes/checkout.rb'
require './classes/promo_code.rb'
require './classes/item.rb'


describe Checkout do

  it "creates object" do
    expect(Checkout.new).to have_attributes({})
  end

  it "takes a list of promo codes" do
    promo_list = [[ "Buy2OrMore", "ProdCodeLH" ]]
    new_checkout = Checkout.new(promo_list)

    expect(new_checkout.promo_codes.first).to have_attributes( rulename: "Buy2OrMore", product_code: "ProdCodeLH" )
  end

  it "takes a invalid list of promo codes" do
    promo_list = [[ "Invalid", "ProdCodeLH" ]]
    new_checkout = Checkout.new(promo_list)

    expect(new_checkout.promo_codes.first.errors).to eq(["Invalid configuration added"])
  end

  it "accepts a scanned item" do 
    checkout = Checkout.new
    item = Item.new("001", "Lavender heart", "925")

    expect(checkout.scan(item)).to eq({:code => "001", :name => "Lavender heart", :price => "925"})
  end

end