require 'csv'

# This is a class structure for each property in the csv file
class Property
	attr_accessor :address, :suburb, :state, :post_code, :financial_institution, :tenancy

	def initialize(property)
		@address = property[:address]
    @suburb = property[:suburb]
    @state = property[:state]
    @post_code = property[:post_code]
    @financial_institution = property[:financial_institution]
    @tenancy = property[:tenancy]
	end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      address: row['address'],
      suburb: row['suburb'],
      state: row['state'],
      post_code: row['post_code'],
      financial_institution: row['financial_institution'],
      tenancy: row['tenancy']
    })
  end

	HEADERS = ['address', 'suburb', 'state', 'post_code', 'financial_institution', 'tenancy']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [address, suburb, state, post_code, financial_institution, tenancy])
  end

	def print_property_address
		puts
		puts "Investment Property Address:"
		puts "\t#{@address}"
		puts "\t#{@suburb}  #{@state}  #{@post_code}"
		puts
	end

	def print_financial_institution
		name, address, suburb, state, post_code = @financial_institution.split('|')

		puts
		puts "Financial Institution for #{@address}"
		puts "\t#{name}"
		puts "\t#{address}"
		puts "\t#{suburb}  #{state}  #{post_code}"
		puts
	end

	def print_tenancy
		start_date, end_date, rental_amount, payment_period = @tenancy.split('|')

		puts
		puts "Current tenancy started on #{start_date} and will finish #{end_date}."
		puts "\tTenants pay $#{rental_amount} #{payment_period}."
		puts
	end

end