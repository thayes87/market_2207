require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  let(:market) { Market.new("South Pearl Street Farmers Market") }
  let(:vendor1) { Vendor.new("Rocky Mountain Fresh") }
  let(:vendor2) { Vendor.new("Ba-Nom-a-Nom") }
  let(:vendor3) { Vendor.new("Palisade Peach Shack") }
  let(:peach) { Item.new({name: 'Peach', price: "$0.75"}) }
  let(:tomato) { Item.new({name: 'Tomato', price: '$0.50'}) }
  let(:razz) { Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"}) }
  let(:banana) { Item.new({name: "Banana Nice Cream", price: "$4.25"}) }

  it 'exists with attributes' do

    expect(market).to be_instance_of(Market)
    expect(market.name).to eq("South Pearl Street Farmers Market")
    expect(market.vendors).to eq([])
  end

  it 'can add vendors to the market' do
   
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.vendors).to eq([vendor1, vendor2, vendor3])
  end

  it 'can pull a list of vendors by name' do
    
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can return a list of vendors that sell a given item that is in stock' do
    
    vendor1.stock(peach, 35)
    vendor1.stock(tomato, 7)
    vendor2.stock(banana, 50)
    vendor2.stock(razz, 25)
    vendor3.stock(peach, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.vendors_that_sell(peach)).to eq([vendor1, vendor3])
    expect(market.vendors_that_sell(banana)).to eq([vendor2])
  end

  it 'can calculate the total inventory of the market' do
    vendor1.stock(peach, 35)
    vendor1.stock(tomato, 7)
    vendor2.stock(banana, 50)
    vendor2.stock(razz, 25)
    vendor3.stock(peach, 65)
    vendor3.stock(razz, 10)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expected = {
      peach => {quantity: 100,
      vendors: [vendor1, vendor3]},
      tomato => {quantity: 7, 
      vendors:[vendor1]},
      banana => {quantity: 50,
      vendors: [vendor2]},
      razz => {quantity: 35,
      vendors: [vendor2, vendor3]}
    }

    expect(market.total_inventory).to eq(expected)
  end

  it 'can identify items that are overstocked' do
    vendor1.stock(peach, 35)
    vendor1.stock(tomato, 7)
    vendor2.stock(banana, 50)
    vendor2.stock(razz, 25)
    vendor3.stock(peach, 65)
    vendor3.stock(razz, 10)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.overstocked_items).to eq([peach])
  end

  it 'can sort all items by alphetical order' do
    vendor1.stock(peach, 35)
    vendor1.stock(tomato, 7)
    vendor2.stock(banana, 50)
    vendor2.stock(razz, 25)
    vendor3.stock(peach, 65)
    vendor3.stock(razz, 10)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
  end
end 