module Irrgarten
  require_relative 'combat_element'
class Weapon < CombatElement
  # Constructor
  def initialize (power,uses)
    @power = power
    super(power,uses)
  end
  def attack
    produce_effect
  end
  def to_s
    "W[#{@power}, #{@uses}"
  end
end
end