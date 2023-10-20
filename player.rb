# frozen_string_literal: true

class Player
  attr_reader :row, :col, :number
  @@MAX_WEAPONS = 2;
  @@MAX_SHIELDS = 3;
  @@INITIAL_HEALTH = 10;
  @@HITS2LOSE = 3;
  def initialize(number, intelligence, strength)
    @number = number
    @intelligence = intelligence
    @strength = strength
    @health = @@INITIAL_HEALTH
    @row = 0
    @col = 0
    @consecutive_hits = 0
    @weapons = []
    @shields = []
  end

  def resurrect

  end
  def set_pos(row,col)
    @row = row
    @col = col
  end
  def dead
    @health <=0
  end
  def move (direction, valid_moves)

  end
  def attack
    @strength + sum_weapons
  end
  def defend (received_attack)
    manage_hit(received_attack)
  end
  def receive_reward

  end
  def to_string
    "Player [Name: #{@name}, Number: #{@number}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}]"
  end
  private
  def receive_weapon(w)

  end
  def receive_shield(s)

  end
  def new_weapon
    power = Dice.weapon_power
    uses = Dice.uses_left
    Weapon.new(power,uses)
  end
  def new_shield
    power = Dice.shield_power
    uses = Dice.uses_left
    Shield.new(power,uses)
  end
  def sum_weapons
    sum = 0.0
    @weapons.each do |w|
      sum += w.attack
    end
    sum
  end
  def sum_shields
    sum = 0.0
    @shields.each do |s|
      sum += s.protect
    end
    sum
  end
  def defensive_energy
    @intelligence + sum_shields
  end
  def manage_hit(received_attack)

  end
  def reset_hits
  @consecutive_hits = 0
  end
  def got_wounded
  @health -= 1
  end
  def inc_consecutive_hits
  @consecutive_hits += 1
  end

end
