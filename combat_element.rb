# frozen_string_literal: true
module Irrgarten
  class CombatElement
    def initialize(effect, uses)
      @effect = effect
      @uses = uses
    end
    def discard
      Dice.discard_element(@uses)
    end
    def to_s
      "CombatElement[#{@power}, #{@uses}"
    end
    protected
    def produce_effect
      if @uses > 0
        @uses = @uses - 1
        @effect
      else
        0.0
      end
    end
  end
end

