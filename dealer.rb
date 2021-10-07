class Dealer
  attr_accessor :bank, :hand

  def initialize
    @hand = Hand.new
    @bank = Bank.new
  end
end
