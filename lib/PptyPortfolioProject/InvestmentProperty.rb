class InvestmentProperty

  attr_accessor :purchase_date, :purchase_price, :bedrooms, :bathrooms, :construction_material

  def initialize(purchase_date, purchase_price, bedrooms, bathrooms, construction_material)
    @purchase_date = purchase_date
    @purchase_price = purchase_price
    @bedrooms = bedrooms
    @bathrooms = bathrooms
    @construction_material = construction_material
  end



end

