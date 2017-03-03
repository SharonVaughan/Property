#!/usr/bin/env ruby
#$: << File.expand_path("../../lib/", __FILE__)

require_relative 'property'
require 'pry'
require 'terminal-table'
require 'csv'


FILE_NAME = 'properties.csv'


def main_menu
	clear
	loop do
		puts "What would you like to do?"
		puts "(R)eview, (A)dd, (U)pdate, or (D)elete a property,\n\t(L)ist all properties or (Q)uit"
		print '>'
		option = gets.chomp.upcase

		case option
		when "R"
			review_a_property
		when "A"
	 		add_property_to_csv
		when "U"
			update_property
		when "D"
			delete_property
		when "L"
			list_all_properties
		when "Q"
			exit(0)
		else
			problem(option)
		end
	end
end


def ask_for_property_from (properties)
  # Loop over each property
  properties.each_with_index do |property, index|
    # Display address and suburb, with an index
    puts "#{index + 1}. #{property.address}, #{property.suburb}"
  end

  index = 0
  loop do
    # Ask for index from user
    print "Select an index: "
    choice = gets.chomp
    index = choice.to_i
    # Only allow valid
    break if index > 0 && index <= properties.length
    puts "Invalid index #{choice}. Try again"
  end

  # Convert from 1-base to 0-base
  index - 1
end


def review_a_property
	properties = read_properties_from_csv
	index = ask_for_property_from properties

	loop do
		puts
		puts "What information would you like to review?"
		puts "\t(A)ddress, (F)inancial institution, (T)enancy, (E)quity or (B)ack"
		puts
		print '>'
		option = gets.chomp.upcase

		case option
		when "A"
			properties[index].print_property_address
		when "F"
			properties[index].print_financial_institution
		when "T"
			properties[index].print_tenancy
		when "E"
			work_out_equity
		when "B"
			main_menu
		else
			problem(option)
		end
	end
end


def read_properties_from_csv
	properties = []
	# Loop over each row in the CSV
	CSV.foreach(FILE_NAME, headers: true) do |row|
		# Convert from CSV::Row to Property instance
		property = Property.from_csv_row(row)
		# Add object to array
		properties << property
	end
	properties # make this printout pretty
end


def write_properties_to_csv(properties)
  CSV.open(FILE_NAME, 'w') do |csv|
    csv << Property::HEADERS
    properties.each do |property|
      csv << property.to_csv_row
    end
  end
end


def update_property
  puts 'Update property'
  puts '-' * 15

  properties = read_properties_from_csv
  index = ask_for_property_from properties
  puts ''

  existing_property = properties[index]
  existing_property.print_property_address
  puts ''    # TO DO ask what information they'd like to update

  puts 'Enter new details:'
  new_property = ask_for_property_details
  properties[index] = new_property

  write_properties_to_csv properties
  puts "Successfully updated property"
end


def delete_property
  puts "Delete property"

  properties = read_properties_from_csv
  index = ask_for_property_from properties

  property = properties[index]
  property.print_property_address  # is this necessary? "property[index]."
  puts "Are you sure you want to delete this property?"
  print "y/n: "
  choice = gets.chomp.downcase
  if choice == "y"
    properties.delete_at index
    write_properties_to_csv properties
    puts "Successfully deleted property"
  end
end


def list_all_properties
	puts 'All investment properties'
  puts '-' * 15
  puts

  properties = read_properties_from_csv
  # Loop over each row in the CSV
  properties.each do |property|
    # Display property details
    puts "#{property.address}, #{property.suburb} #{property.state} #{property.post_code}"
		name, address, suburb, state, post_code = property.financial_institution.split('|')
    puts "\t#{name}, #{address}  #{state}  #{post_code}"
		start_date, end_date, rental_amount, payment_period = property.tenancy.split('|')
    puts "\tTenancy contract: #{start_date} - #{end_date}, $#{rental_amount} #{payment_period}"
    puts
  end
end


def append_property_to_csv(property)
  CSV.open(FILE_NAME, 'a+') do |csv|
    csv << property.to_csv_row
  end
end


def ask_for_property_details
  print "Address: "
  address = gets.chomp
  print "Suburb: "
  suburb = gets.chomp
  print "State: "
  state = gets.chomp
  print "Post Code: "
  post_code = gets.chomp.to_i
  print "Financial Institution: (Please format answer as Name|address|suburb|state|post code)"
  financial_institution = gets.chomp
  print "Tenancy:  (Please format answer as start date|end date|rental_amount|payment_period)"
  tenancy = gets.chomp
  # Create new property
  Property.new({
    address: address,
    suburb: suburb,
    state: state,
    post_code: post_code,
    financial_institution: financial_institution,
    tenancy: tenancy
  })
end


def add_property_to_csv
  puts 'Add property'
  puts '-' * 15
  puts

  property = ask_for_property_details

  # Read all properties
  properties = read_properties_from_csv
  # Add property to end of array
  append_property_to_csv property
  puts "Successfully added property"
  puts
end


# Works out how much equity is available for a property
# Current figures will be used here so won't be part of the csv
def work_out_equity
	puts "What is the current mortgage? (Just the numbers, please)"
	puts
	print '>'
	total_mortgage_amount = gets.chomp.to_i

	puts "Do you have a current valuation?"
	puts
	print '>'
	response = gets.chomp.downcase

	if response == "n"
		Process.fork do
			exec ("open https://www.domain.com.au/property-profile")
		end
	end

	puts "What is the valuation? (Just the numbers, please)"
	puts
	print '>'
	current_valuation_amount = gets.chomp.to_i
	puts "The equity is currently: $#{current_valuation_amount - total_mortgage_amount}"
	puts
end  # TO DO ask user if the want add this to another properties equity


def problem(reason_for_error)
	puts "\aOops, we have a problem here." #\a escape character Bell for error warning
	puts "Your entry '#{reason_for_error}' is incorrect."
	puts
end


def clear
	system "clear" or system "cls"
end


main_menu



