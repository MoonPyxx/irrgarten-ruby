require_relative '../game_state'

module Control

  class Controller
    def initialize(game,view)
      @game = game
      @view = view
    end

    def play
      end_of_game = false
      while (!end_of_game)
        @view.show_game(@game.get_game_state)
        direction = @view.next_move 
        end_of_game = @game.next_step(direction)
      end
      @view.show_game(@game.get_game_state)
    end
  end # class   
end # module        