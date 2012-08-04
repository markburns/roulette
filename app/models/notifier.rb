class Notifier
  class << self
    def display_phone number
      Pusher['bets'].trigger!('new_player', {phone_number: number})
    end

    def display_bet position, amount
      Pusher['bets'].trigger!('new_bet', {position: position, amount: amount})
    end
  end
end
