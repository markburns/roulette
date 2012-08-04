class BetsController < ApplicationController
  respond_to :xml, :html
  def new
    Notifier.display_phone number

    render 'new'
  end

  def create
    @bet = BetParser.new params["Digits"]


    Notifier.display_bet @bet
  end

  private
  def phone_number
    params["From"]
  end

  def amount
    BetParser.params["Digits"]
  end
end
