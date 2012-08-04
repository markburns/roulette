class BetParser
  attr_reader :amount, :position

  def initialize digits
    a, p = digits.split "*"
    @amount   = a.to_i
    @position = p.to_i
    @valid = (@amount > 0) and valid_position?
  end

  def valid?
    @valid
  end

  def valid_position?
    (@position >= 0) and
    (@position <=36)
  end
end
