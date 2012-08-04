class Notifier
  class << self
    def display_phone number
      Pusher['bets'].trigger 'new_player', {phone_number: number}
    end

    def display_bet bet
      message = { phone_number: bet.phone_number,
                  position:     bet.position,
                  amount:       bet.amount}

      Pusher['bets'].trigger 'new_bet', message
    end
  end
end
