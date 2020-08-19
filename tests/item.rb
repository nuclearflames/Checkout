require './classes/item.rb'


describe Item do

  it "creates object" do
    expect(Item.new).to have_attributes({})
  end

  it "Creates an item" do
    expect(Item.new("001", "Lavender heart", "925")).to have_attributes( code: "001", name: "Lavender heart", price: "925" )
  end

end