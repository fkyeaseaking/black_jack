module DealerTurn
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
end
