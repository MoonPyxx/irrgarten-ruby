# frozen_string_literal: true
require_relative 'UI/textUI'
require_relative 'game'
module Irrgarten
  class TestP3
    def self.main
      game = Game.new(2,true)
      view = UI::TextUI.new

=begin
      game.next_step(Directions::LEFT)
      view.show_game(game.get_game_state)
      game.next_step(Directions::RIGHT)
      view.show_game(game.get_game_state)
=end
      #Combates
      # Probar resurrecion
      current_player = game.current_player
      current_player.health = 0
      game.next_step(Directions::UP)
      current_player2 = game.current_player
      current_player2.health = 0
      view.show_game(game.get_game_state)
      game.next_step(Directions::DOWN)
      view.show_game(game.get_game_state)

      5.times do
        game.next_step(Directions::UP)
        view.show_game(game.get_game_state)
        game.next_step(Directions::DOWN)
        view.show_game(game.get_game_state)
        game.next_step(Directions::DOWN)
        view.show_game(game.get_game_state)
        game.next_step(Directions::UP)
        view.show_game(game.get_game_state)
      end
    end
  end
  Irrgarten::TestP3.main
end
