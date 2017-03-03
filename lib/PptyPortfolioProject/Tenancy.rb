class Tenancy

  attr_accessor :start_date, :end_date, :rental_amount, :payment_period

  def initialize(start_date, end_date, rental_amount, payment_period)
    @start_date = start_date
    @end_date = end_date
    @rental_amount = rental_amount
    @payment_period = payment_period  ## pdf of contract???
  end



end


