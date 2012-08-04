class BetParser
  attr_reader :amount, :position, :phone_number

  def initialize digits, phone_number
    a, p = digits.split "*"
    @amount   = a.to_i
    @position = p.to_i
    @phone_number = phone_number
    @valid =  valid_amount? and valid_position?
    debugger
    1
  end

  def valid?
    @valid
  end

  def valid_amount?
    @amount > 0
  end

  def valid_position?
    (@position >= 0) and
    (@position <=36)
  end
end
