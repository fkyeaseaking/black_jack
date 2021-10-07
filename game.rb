class Game
  BET = 10.freeze

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

      turn

      puts "Want continue? (y/n)"
      input = gets.chomp.downcase
      break if input == "n"
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

  def player_turn
    show_cards(:closed)
    make_bet

    puts "Choose action"
    puts "Enter 'skip' if you want to skip turn"
    puts "Enter 'add' if you want to add card to hand"
    puts "Enter 'open' if you want to open hands"

    action = gets.chomp.downcase

    send("player_#{action}")
  end

  def player_skip
    puts "Skipping turn"
  end

  def player_add
    add_card(@player)
  end

  def player_open
    decide_winner
  end

  def dealer_turn
    score = score(@dealer)

    score > 16 ? dealer_skip : dealer_add
  end

  def dealer_skip
    puts "Dealer skipping"
  end

  def dealer_add
    add_card(@dealer)
    puts "Dealer added a card"
  end

  def decide_winner
    show_cards(:open)

    player_score = score(@player)
    dealer_score = score(@dealer)

    if player_score > 21
      player_loss
    elsif player_score < 22 && player_score > dealer_score && dealer_score < 22
      player_won
    elsif player_score == dealer_score
      tie
    else
      player_loss
    end

    @turn_end +=1
  end

  def turn_ended?
    @turn_end > 0
  end

  def add_card(player)
    player.hand.add_card(@deck.card!)
  end

  def show_cards(option)
    puts "Your cards"
    puts @player.hand.cards.join(" ")
    puts "#{score(@player)} points"
    puts "Dealer cards"

    case option
    when :closed
      @dealer.hand.cards.length.times { print "* " }
      puts "Score unknown"
    when :open
      puts @dealer.hand.cards.join(" ")
      puts score(@dealer)
    end
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
