class Address

  attr_accessor :address, :suburb, :post_code, :state

  def initialize(address, suburb, post_code, state)
    @address = address
    @suburb = suburb
    @post_code = post_code
    @state = state
  end



end


# person_a has prop_1, prop2, prop_4, prop_28
# prop_1 belongs to person_a
# prop_1 also belongs to financial_i_a

# fi has their own a list of properties
# person has their own a list of properties
# property has both an owner and a fi

