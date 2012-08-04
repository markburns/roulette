class BetsController < ApplicationController
  respond_to :xml, :html
  def new
    Notifier.display_phone number

    render 'new'
  end

  def create
    Notifier.display_bet bet
  end

  private
  def phone_number
    params["From"]
  end

  def bet
    params["Digits"]
  end
end
