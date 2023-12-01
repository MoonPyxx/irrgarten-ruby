module Irrgarten
class Shield < CombatElement
  # Constructor
  def initialize (protection,uses)
    @protection = protection
    @uses = uses
  end
  def protect
    if @uses > 0
      @uses -= 1
      @protection
    else
      0
    end
  end
  def to_s
    "S[#{@protection}, #{@uses}"
  end
  def discard
    Dice.discard_element(@uses)
  end
end
end