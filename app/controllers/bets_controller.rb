class BetsController < ApplicationController
  respond_to :xml, :html
  def new
    number = bet.phone_number
    raise "number"
    Notifier.display_phone number

    render 'new'
  end

  def create
    if bet.valid?
      Notifier.display_bet bet
      render 'new'
    else
      render 'create'
    end
  end

  private

  def digits
    if params["Digits"]
      params["Digits"]
    else
      Notifier.display_phone phone_number
      params["body"] || params["Body"]
    end
  end

  def phone_number
    params["From"]
  end

  def bet
    @bet ||= BetParser.new digits, phone_number
  end
end
