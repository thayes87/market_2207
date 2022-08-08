class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendors.map do |vendor|
      vendor.name 
    end 
  end

  def vendors_that_sell(product)
    vendor_list = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if item.name == product.name
          vendor_list << vendor
        end
      end
    end
    vendor_list
  end
end
