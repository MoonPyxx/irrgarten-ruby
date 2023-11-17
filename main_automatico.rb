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
      # comprobar si resucitar funciona
      player = game.current_player
      player.health = 0
      10.times do
        game.next_step(Directions::LEFT)
        view.show_game(game.get_game_state)
      end
      # comprobar a mover a un jugador a una posición concreta
      labyrinth = game.labyrinth
      player = game.current_player
      labyrinth.put_player_2d(player.row,player.col,9,6,player)
      view.show_game(game.get_game_state)
    end
  end
  Irrgarten::TestP3.main
end
