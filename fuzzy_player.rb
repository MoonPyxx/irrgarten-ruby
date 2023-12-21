# frozen_string_literal: true
require_relative 'player'
module Irrgarten
class FuzzyPlayer < Player
  def initialize(other)
    super(other.name, other.intelligence, other.strength)
    @number = other.number
  end
  def move(direction, valid_moves)
    Dice.next_step(direction,valid_moves,@intelligence)
  end
  def attack
    sum_weapons+Dice.intensity(@strength)
  end

  def to_string
    "Fuzzy " + super.to_s
  end
  protected
  def defensive_energy
    sum_shields + Dice.intensity(@intelligence)
  end
end
end
