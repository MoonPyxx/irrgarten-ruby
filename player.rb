# frozen_string_literal: true
require_relative 'Dice'
require_relative 'Weapon'
require_relative 'Shield'
module Irrgarten
class Player < LabyrinthCharacter
  attr_reader :row, :col, :number
  # modificador de health para pruebas en main_automatico
  attr_writer :health
  @@MAX_WEAPONS = 2;
  @@MAX_SHIELDS = 3;
  @@INITIAL_HEALTH = 10;
  @@HITS2LOSE = 3;
  def initialize(number, intelligence, strength)
    @number = number
    @name = "Player # " + number.to_s
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
    @weapons.clear
    @shields.clear
    @health = @@INITIAL_HEALTH
    @consecutive_hits = 0
  end
  def set_pos(row,col)
    @row = row
    @col = col
  end
  def dead
    @health <= 0
  end
  def move (direction, valid_moves)
    size = valid_moves.size
    contained = false
    valid_moves.each do |d|
      if d == direction
        contained = true
        break
      end
    end
    if size > 0 && !contained
      valid_moves[0]
    else
      direction
    end
    end
  def attack
    @strength + sum_weapons
  end
  def defend (received_attack)
    manage_hit(received_attack)
  end
  def receive_reward
    w_reward = Dice.weapons_reward
    s_reward = Dice.shields_reward
    puts "w " + w_reward.to_s
    puts "s " + s_reward.to_s
    w_reward.times do
      w_new = new_weapon
      receive_weapon(w_new)
    end
    s_reward.times do
      s_new = new_shield
      receive_shield(s_new)
    end
    extra_health = Dice.health_reward
    @health += extra_health
  end
  def to_string
    weapons_str = @weapons.map { |w| w.to_s}.join(', ')
    shields_str = @shields.map {|s| s.to_s}.join(', ')
    "Player [Name: #{@name}, Intelligence: #{@intelligence}, Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col} ]\n" +
      "Weapons: [#{weapons_str}] " + " SumWeapons: #{sum_weapons}\n" +
      "Shields: [#{shields_str}] "  + " SumShields: #{sum_shields}"
  end
  private
  def receive_weapon(w)
    @weapons.each_with_index do |wi,i|
      if wi.discard
        @weapons.delete_at(i)
      end
    end
    size = @weapons.size
    if size<@@MAX_WEAPONS
      @weapons << w
    end
  end
  def receive_shield(s)
    @shields.each_with_index do |si,i|
      discard = si.discard
      if discard
        @shields.delete_at(i)
      end
    end
    size = @shields.size
    if size<@@MAX_SHIELDS
      @shields << s
    end
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
    defense = defensive_energy
    lose = false

    if defense < received_attack
      got_wounded
      inc_consecutive_hits
    else
      reset_hits
    end
    if @consecutive_hits == @@HITS2LOSE || dead
      reset_hits
      lose = true
    else
      lose = false
    end
    lose
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
end