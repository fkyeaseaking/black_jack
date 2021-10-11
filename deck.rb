class Deck
  attr_reader :cards

  CARD_NAMES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  CARD_SUITS = %w[♠ ♥ ♦ ♣].freeze

  def initialize
    @cards = make_deck.shuffle!
  end

  def card!
    @cards.pop
  end

  private

  def make_deck
    arr = []

    CARD_NAMES.each do |name|
      CARD_SUITS.each { |suit| arr << name + suit }
    end

    arr
  end
end
