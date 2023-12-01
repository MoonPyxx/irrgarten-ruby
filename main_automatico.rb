# frozen_string_literal: true
require_relative 'UI/textUI'
require_relative 'controller/controller'
require_relative 'Game'
module Irrgarten
  class TestP3
    def self.main
      game = Game.new(2,true)
      view = UI::TextUI.new
      # Combates
      game.next_step(Directions::LEFT)
      view.show_game(game.get_game_state)
      game.next_step(Directions::RIGHT)
      view.show_game(game.get_game_state)

    end
  end
  Irrgarten::TestP3.main
end
