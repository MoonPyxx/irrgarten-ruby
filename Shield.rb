module Irrgarten
  require_relative 'combat_element'
class Shield < CombatElement
  # Constructor
  def initialize (protection,uses)
    @protection = protection
    super(protection,uses)
  end
  def protect
    produce_effect
  end
  def to_s
    "S[#{@protection}, #{@uses}"
  end
end
end