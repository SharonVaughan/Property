
class Repairs

  attr_accessor :trade, :description, :start_date, :finish_date, :cost

  def initialize(trade, description, start_date, finish_date, cost)
    @trade = trade
    @description = description
    @start_date = start_date
    @finish_date = finish_date
    @cost = cost
  end



end



