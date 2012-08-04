class BetsController < ApplicationController
  respond_to :xml, :html
  def new
    Notifier.display_phone phone_number

    render 'new'
  end

  def create
    @bet = BetParser.new digits, phone_number

    if @bet.valid?
      Notifier.display_bet @bet
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
end
