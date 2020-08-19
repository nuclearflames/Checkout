require './classes/checkout.rb'


describe Checkout do

  co = {}

  it "creates object" do
    expect(Checkout.new).to have_attributes({})
  end

end