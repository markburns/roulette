class BetParser
  attr_reader :amount, :position

  def initialize digits
    a, p = digits.split "*"
    @amount   = a.to_i
    @position = p.to_i
  end
end
