class Player

  attr_reader :number, :symbol

  def initialize(number, symbol)
    @number = number
    @symbol = symbol
  end

  def to_s
    "Player #{@number}"
  end
end