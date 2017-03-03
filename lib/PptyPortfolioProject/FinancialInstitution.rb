
class FinancialInstitution

  attr_accessor :bsb, :account_number, :purchase_price, :type_of_loan, :interest_rate, :term, :total_mortgage, mortgage_repayments

  def initialize(bsb, account_number, purchase_price, type_of_loan, interest_rate, term, total_mortgage, mortgage_repayments)
  	@bsb = bsb
    @account_number = account_number
    @purchase_price = purchase_price
    @type_of_loan = type_of_loan
    @interest_rate = interest_rate
    @term = term
    @total_mortgage = total_mortgage
    @mortgage_repayments = mortgage_repayments
  end



end

