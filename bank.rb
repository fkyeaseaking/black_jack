class Bank
  attr_accessor :amount

  def initialize
    @amount = 100
  end

  def add_funds(value)
    @amount += value
  end

  def withdraw_funds(value)
    @amount -= value
  end
end
