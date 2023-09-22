# frozen_string_literal: true

class GameState
  # Constructor
  def initialize(labyrinthv, players, monsters, current_player, winner, log)
    @labyrinthv = labyrinthv
    @players = players
    @monsters = monsters
    @current_player = current_player
    @winner = winner
    @log = log
  end
  # Consultores
  attr_reader :labyrinthv, :players, :monsters, :current_player, :winner, :log
end
