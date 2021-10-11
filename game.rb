require_relative "info"
require_relative "player_turn"
require_relative "dealer_turn"

class Game
  include Info
  include PlayerTurn
  include DealerTurn

  BET = 10

  def start
    puts "Enter name:"
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Dealer.new

    game_flow
  end

  private

  def game_flow
    loop do
      reset_hands!

      make_bet
      turn

      puts "Enter 'stop' if you want to stop game"
      input = gets.chomp.downcase
      break if input.downcase == "stop"
    end
  end

  def reset_hands!
    @player.hand.cards.clear
    @dealer.hand.cards.clear
  end

  def turn
    start_turn
    player_turn

    until turn_ended?
      dealer_turn
      decide_winner
    end
  end

  def start_turn
    @turn_end = 0
    @deck = Deck.new
    2.times { add_card(@player) }
    2.times { add_card(@dealer) }
  end

  def decide_winner
    show_cards(:open)

    result = TurnResult.call(score(@player), score(@dealer))

    send(result.to_s)

    @turn_end += 1
  end

  def turn_ended?
    @turn_end.positive?
  end

  def add_card(player)
    player.hand.add_card(@deck.card!)
  end

  def score(player)
    player.hand.calculate!
  end

  def make_bet
    @player.bank.withdraw_funds(BET)
    @dealer.bank.withdraw_funds(BET)
  end

  def player_won
    @player.bank.add_funds(BET * 2)
    puts "You won!"
  end

  def player_loss
    @dealer.bank.add_funds(BET * 2)
    puts "You loss!"
  end

  def tie
    @player.bank.add_funds(BET)
    @dealer.bank.add_funds(BET)
    puts "Tie"
  end
end
