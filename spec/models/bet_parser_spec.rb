require './app/models/bet_parser'

describe BetParser do
  it "obfuscates the incoming number" do
    @bet = BetParser.new "0", "+447903123456"
    @bet.phone_number.should == "+44790....456"
  end

  describe "bets" do
    {
      "0"   => {position: 0,    valid: true},
      "1"   => {position: 1,    valid: true},
      "36"  => {position: 36,   valid: true},
      "37"  => {position: 37,    valid: false},
      "122" => {position: 122,  valid: false},
      "-1"  => {position: -1,   valid: false}
    }.each do |input, output|
      specify do
        @bet = BetParser.new input
        @bet.position.should == output[:position]
      end
    end
  end

end
