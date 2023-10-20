# frozen_string_literal: true

class Monster
  @@INITIAL_HEALTH = 5

  def initialize(name, intelligence, strength)
    @name = name
    @intelligence = intelligence
    @strength = strength
    @health = @@INITIAL_HEALTH
    @row = 0
    @col = 0
  end
  def dead
    @health <= 0
  end
  def attack
    Dice.intensity(@strength)
  end
  def defend(received_attack)

  end
  def set_pos(row,col)
  @row = row
  @col = col
  end
  def to_string
    "Monster [Name: #{name}, Intelligence: #{intelligence}, Strength: #{strength}, Health: #{health}, Row: #{row}, Col: #{col}]"
  end
  private
  def got_wounded
    @health -= 1
  end

end
