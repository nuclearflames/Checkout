require './classes/checkout.rb'
require './classes/promo_code.rb'
require './classes/item.rb'

Encoding.default_external = Encoding::UTF_8

describe Checkout do

  it "creates object" do
    expect(Checkout.new).to have_attributes({})
  end

  it "takes a list of promo codes" do
    promotional_rules = [[ "Buy2OrMore", "ProdCodeLH" ]]
    new_checkout = Checkout.new(promotional_rules)

    expect(new_checkout.promo_codes.first).to have_attributes( rulename: "Buy2OrMore", product_code: "ProdCodeLH" )
  end

  it "takes a invalid list of promo codes" do
    promotional_rules = [[ "Invalid", "ProdCodeLH" ]]
    new_checkout = Checkout.new(promotional_rules)

    expect(new_checkout.promo_codes.first.errors).to eq(["Invalid configuration added"])
  end

  it "accepts a scanned item" do 
    checkout = Checkout.new
    item = Item.new("001", "Lavender heart", "925")

    expect(checkout.scan(item)).to eq({:code => "001", :name => "Lavender heart", :price => "925"})
    expect(checkout.items.size).to eq(1)
  end

  it "strip items of symbols" do
    checkout = Checkout.new
    item = Item.new("001", "Lavender heart", "£9.25")

    expect(checkout.scan(item)).to eq({:code => "001", :name => "Lavender heart", :price => "925"})
    expect(checkout.items.size).to eq(1)
  end

  it "calculates the total of 1 item" do
    item = Item.new("001", "Lavender heart", "925")

    checkout = Checkout.new
    checkout.scan(item)

    expect(checkout.total).to eq("£9.25")

  end

  it "calculates the total of 2 different items" do
    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("003", "Kids T-shirt", "1995")

    checkout = Checkout.new
    checkout.scan(item)
    checkout.scan(item2)

    expect(checkout.total).to eq("£29.20")

  end

  it "calculates the applied promotion of 1 item" do
    promotional_rules = [[ "Buy2OrMore", "001" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("001", "Lavender heart", "925")
    item3 = Item.new("001", "Lavender heart", "925")
    item4 = Item.new("001", "Lavender heart", "925")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)
    checkout.scan(item4)

    expect(checkout.total).to eq("£34.00")

  end

  it "Ensure global promo rules are used after individual rules" do
    promotional_rules = [[ "10percentoff" ], [ "Buy2OrMore", "001" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("001", "Lavender heart", "925")
    item3 = Item.new("002", "Personalised Cufflinks", "4500")
    item4 = Item.new("001", "Lavender heart", "925")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)
    checkout.scan(item4)

    expect(checkout.total).to eq("£63.45")

  end

  it "Tests global discount rule of 10 percent off over £60" do
    promotional_rules = [[ "10percentoff" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("001", "Lavender heart", "925")
    item3 = Item.new("002", "Personalised Cufflinks", "4500")
    item4 = Item.new("001", "Lavender heart", "925")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)
    checkout.scan(item4)

    expect(checkout.total).to eq("£65.48")

  end

  it "Combined promotion" do
    promotional_rules = [[ "Buy2OrMore", "001" ], [ "10percentoff" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("001", "Lavender heart", "925")
    item3 = Item.new("002", "Personalised Cufflinks", "4500")
    item4 = Item.new("001", "Lavender heart", "925")
    item5 = Item.new("001", "Lavender heart", "925")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)
    checkout.scan(item4)
    checkout.scan(item5)

    expect(checkout.total).to eq("£71.10")

  end

  it "Challenge Test results 1" do
    promotional_rules = [[ "Buy2OrMore", "001" ], [ "10percentoff" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("002", "Personalised Cufflinks", "4500")
    item3 = Item.new("003", "Personalised Cufflinks", "1995")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)

    expect(checkout.total).to eq("£66.78")

  end

  it "Challenge Test results 2" do
    promotional_rules = [[ "Buy2OrMore", "001" ], [ "10percentoff" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("003", "Kids T-shirt", "1995")
    item3 = Item.new("001", "Lavender heart", "925")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)

    expect(checkout.total).to eq("£36.95")

  end

  it "Challenge Test results 3" do
    promotional_rules = [[ "Buy2OrMore", "001" ], [ "10percentoff" ]]

    item = Item.new("001", "Lavender heart", "925")
    item2 = Item.new("002", "Personalised Cufflinks", "4500")
    item3 = Item.new("001", "Lavender heart", "925")
    item4 = Item.new("003", "Kids T-shirt", "1995")

    checkout = Checkout.new(promotional_rules)
    checkout.scan(item)
    checkout.scan(item2)
    checkout.scan(item3)
    checkout.scan(item4)

    expect(checkout.total).to eq("£73.76")

  end

end