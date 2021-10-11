module Info
  def show_cards(option)
    player_info
    dealer_info(option)
  end

  private

  def player_info
    puts "Your cards: #{@player.hand.cards.join(" ")}, score: #{score(@player)}, bank: #{@player.bank.amount}"
  end

  def dealer_info(option)
    case option
    when :closed
      puts "Dealer cards: #{@dealer.hand.cards.length.times do
                              print "* "
                            end }, score: Unknown, bank: #{@dealer.bank.amount}"
    when :open
      puts "Dealer cards: #{@dealer.hand.cards.join(" ")}, score: #{score(@dealer)}, bank: #{@dealer.bank.amount}"
    end
  end
end
