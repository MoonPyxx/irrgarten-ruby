# frozen_string_literal: true

class Player
  @@MAX_WEAPONS = 2;
  @@MAX_SHIELDS = 3;
  @@INITIAL_HEALTH = 10;
  @@HITS2LOSE = 3;
  attr_accessor :name, :number, :intelligence, :strength, :health, :row, :col, :consecutiveHits
  def initialize(number, intelligence, strength)
    @number = number
    @intelligence = intelligence
    @strength = strength
    @health = @@INITIAL_HEALTH
    @row = 0
    @col = 0
    @consecutive_hits = 0
  end

  def resurrect

  end
  attr_reader :row, :col, :number
  def set_pos(row,col)

  end
  def dead

  end
  def move (direction, valid_moves)

  end
  def attack

  end
  def defend (received_attack)

  end
  def receive_reward

  end
  def to_string

  end
  private
  def receive_weapon(w)

  end
  def receive_shield(s)

  end
  def new_weapon

  end
  def new_shield

  end
  def sum_weapons

  end
  def sum_shields

  end
  def defensive_energy

  end
  def manage_hit(received_attack)

  end
  def reset_hits

  end
  def got_wounded

  end
  def inc_consecutive_hits

  end

end
