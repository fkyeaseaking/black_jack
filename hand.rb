class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def calculate!
    card_names = @cards.map { |card| card[0...-1] }
    aces = card_names.select { |card| card == "A" }
    other_cards = card_names.select { |card| card != "A" }
    score = 0

    other_cards.each { |card| score += card_score(card) }
    aces.each { |i| (score + 11) > 21 ? score += 1 : score += 11 }

    score
  end

  def add_card(card)
    @cards << card
  end

  private

  def card_score(card)
    card.to_i.zero? ? 10 : card.to_i
  end
end
