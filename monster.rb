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

  end
  def attack

  end
  def defend(received_attack)

  end
  def set_pos(row,col)

  end
  def to_string

  end
  private
  def got_wounded

  end

end
