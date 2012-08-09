class BetParser
  attr_reader :position, :phone_number

  def initialize digits, phone_number = nil
    @position = digits.to_i
    @phone_number = obfuscate(phone_number) if phone_number
  end

  def valid?
    valid_position?
  end

  private

  def valid_position?
    (@position >= 0) and
    (@position <=36)
  end

  def obfuscate(n)
    n[0..5] + "...." + n[-3..-1]
  end
end
