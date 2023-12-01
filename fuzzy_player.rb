# frozen_string_literal: true
require_relative 'player'
module Irrgarten
class FuzzyPlayer < Player
  def initialize(other)
    super(other.name, other.intelligence, other.strength)
  end
  def attack
    sum_weapons+Dice.intensity(@strength)
  end

  def to_s
    "Fuzzy " + super
  end
  protected
  def defensive_energy
    sum_shields + Dice.intensity(@intelligence)
  end

end
end
