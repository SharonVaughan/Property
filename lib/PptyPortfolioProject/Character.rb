class Character

  attr_accessor :name, :phone_number, :email, :website, :role

  def initialize(name, phone_number, email, website, role)
    @name = name
    @phone_number = phone_number
    @email = email
    @website = website
    @role = role ## role (bank, tradesperson, REagency, REagent)
  end



end


