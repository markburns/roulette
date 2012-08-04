require './app/models/bet_parser'

describe BetParser do
  {
    "123*0"   => {amount: 123, position: 0,    valid: true},
    "123*33"  => {amount: 123, position: 33,   valid: true},
    "4*1"     => {amount: 4,   position: 1,    valid: true},
    "123*2"   => {amount: 123, position: 2,    valid: true},
    "123*122" => {amount: 123, position: 122,  valid: false},
    "0*122"   => {amount: 0,   position: 122,  valid: false}
  }.each do |input, output|
    specify do
      @bet= BetParser.new input, '0743434343'
      @bet.amount.  should == output[:amount]
      @bet.position.should == output[:position]
    end
  end


end
