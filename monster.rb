# frozen_string_literal: true
module Irrgarten
  require_relative 'labyrinth_character'
class Monster < LabyrinthCharacter
  @@INITIAL_HEALTH = 5

  def initialize(name, intelligence, strength)
    super(name, intelligence, strength, @@INITIAL_HEALTH)
    @row = 0
    @col = 0
  end
  def attack
    Dice.intensity(@strength)
  end
  def defend(received_attack)
    if dead
      false
    end
    defensive_energy = Dice.intensity(@intelligence)
    if defensive_energy < received_attack
      got_wounded
      dead
    end
    false
  end
  def to_string
    "Monster [Number: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}]"
  end
  end
end
