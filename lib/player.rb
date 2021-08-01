# frozen_string_literal: true

# Player stores each respective player's name and gamepiece
# Two player instances are used for every match
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
