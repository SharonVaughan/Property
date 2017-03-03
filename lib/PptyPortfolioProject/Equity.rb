class Equity

  attr_accessor :total_mortgage_amount, :current_valuation_date, :current_valuation_amount, :current_equity

  def initialize(total_mortgage_amount, current_valuation_date, current_valuation_amount, current_equity)
    @total_mortgage_amount = total_mortgage_amount
    @current_valuation_date = current_valuation_date
    @current_valuation_amount = current_valuation_amount
    @current_equity = current_equity
  end



end


