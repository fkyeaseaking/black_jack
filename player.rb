class Player
  attr_accessor :bank

  def initialize(name)
    @name = name
    @bank = Bank.new
    @hand = Hand.new
  end
end
