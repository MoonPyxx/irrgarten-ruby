# frozen_string_literal: true
module Irrgarten
class LabyrinthCharacter
  attr_reader :col, :row, :intelligence, :strength, :name
  attr_accessor :health
  def initialize(name,intelligence, strength, health)
    @name = name
    @intelligence = intelligence
    @strength = strength
    @health = health
    @row = 0
    @col = 0
  end
  def self.copy(other)
    new(other.name, other.intelligence, other.strength, other.health)
  end
  def dead
    @health <= 0
  end
  def set_pos(row,col)
    @row = row
    @col = col
  end
  def to_string
    "[Name: #{@name}, Intelligence: #{@intelligence},
 Strength: #{@strength}, Health: #{@health}, Row: #{@row}, Col: #{@col}]"
  end
  protected
  def got_wounded
    @health = @health - 1
  end
end
end