module PlayerTurn
  ACTIONS = {
    skip: "skip turn",
    add: "add card to hand",
    open: "open hands"
  }.freeze

  def player_turn
    show_cards(:closed)

    puts "#{@player.name}, choose action"
    ACTIONS.each { |action, description| puts "Enter '#{action}' if you want to #{description}" }

    action = gets.chomp.downcase

    send("player_#{action}")
  rescue NoMethodError
    puts "Wrong action"
    retry
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
end
