require './app/models/bet_parser'

describe BetParser do
  {
    "123*0" =>  {amount: 123, position: 0},
    "123*33" => {amount: 123, position: 33},
    "4*1"   =>  {amount: 4,   position: 1},
    "123*2" =>  {amount: 123, position: 2}
  }.each do |input, output|
    specify do
      @bet= BetParser.new input
      @bet.amount.  should == output[:amount]
      @bet.position.should == output[:position]
    end
  end


end
