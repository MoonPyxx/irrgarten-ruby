module Irrgarten
class Dice

  # Atributos de clase
  @@MAX_USES = 5
  @@MAX_INTELLIGENCE = 10.0
  @@MAX_STRENGTH = 10.0
  @@RESURRECT_PROB = 0.3
  @@WEAPONS_REWARD = 2
  @@SHIELDS_REWARD = 3
  @@HEALTH_REWARD = 5
  @@MAX_ATTACK = 3.0
  @@MAX_SHIELD = 2.0

  @@generator = Random.new

  # Metodos de clase
  def self.random_pos(max)
    @@generator.rand(max)
  end
  def self.who_starts(nplayers)
    @@generator.rand(nplayers)
  end
  def self.random_intelligence
    @@generator.rand(@@MAX_INTELLIGENCE)
  end
  def self.random_strength
    @@generator.rand(@@MAX_STRENGTH)
  end
  def self.resurrect_player
    @@generator.rand < @@RESURRECT_PROB
  end
  def self.weapons_reward
    @@generator.rand(@@WEAPONS_REWARD + 1)
  end
  def self.shields_reward
    @@generator.rand(@@SHIELDS_REWARD + 1)
  end
  def self.health_reward
    @@generator.rand(@@HEALTH_REWARD + 1)
  end
  def self.weapon_power
    @@generator.rand(@@MAX_ATTACK)
  end
  def self.shield_power
    @@generator.rand(@@MAX_SHIELD)
  end
  def self.uses_left
    @@generator.rand(@@MAX_USES + 1)
  end
  def self.intensity(competence)
    @@generator.rand(competence)
  end
  def self.discard_element(uses_left)
    if uses_left == @@MAX_USES
      return false
    elsif uses_left == 0
      return true
    else
      probability = 1.0 - (uses_left.to_f / @@MAX_USES)
      return @@generator.rand < probability
    end
  end
  # Practica 4
  def self.next_step(preference, valid_moves, intelligence)
    if @@generator.rand < (intelligence/@@MAX_INTELLIGENCE)
      preference
    else
      valid_moves[@@generator.rand(valid_moves.length)]
    end
  end
end
end