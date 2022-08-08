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

  def total_inventory
    items_with_summed_quantities = {}

    all_items.each do |vendor_items|
      vendor_items.each do |item, quantity|
        if items_with_summed_quantities.keys.include?(item)
          exisiting_qty = items_with_summed_quantities[item]
          items_with_summed_quantities[item] = exisiting_qty += quantity
        else
          items_with_summed_quantities[item] = quantity
        end
      end
    end

    final_hash = {}
    items_with_summed_quantities.each do |item, quantity|
      final_hash[item] = {quantity: quantity, vendors: vendors_that_sell(item)}
    end
    final_hash
  end

  def all_items
    vendors.map do |vendor|
      vendor.inventory 
    end
  end

  def overstocked_items 
    overstocked = []
    total_inventory.each do |item, item_details|
      if item_details[:quantity] > 50 && item_details[:vendors].count > 1
        overstocked << item 
      end
    end
    overstocked
  end

  def sorted_item_list
    items = total_inventory.keys
    items.map do |item|
      item.name
    end.sort
  end
end
