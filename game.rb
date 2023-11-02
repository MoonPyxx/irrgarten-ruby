# frozen_string_literal: true

class Game
  @@MAX_ROUNDS = 10
  def initialize(n_players)
    @current_player_index = current_player_index
    @players = []
    @monsters = []
    @log = ""

    n_players.times do |i|
      intelligence = Dice.random_intelligence
      strength = Dice.random_strength
      @players << Player.new((i+ '0').chr, intelligence, strength)
    end

    @current_player_index = Dice.who_starts(n_players)
    exit_row = Dice.random_pos(10)
    exit_col = Dice.random_pos(10)
    @labyrinth = Labryinth.new(10,10,exit_row, exit_col)
    configure_labyrinth
  end

  def finished
    labyrinth.have_a_winner
  end
  def next_step(preferred_direction)

  end
  def get_game_state
    labyrinth_string= @labyrinth.to_s
    players_string = @players.map(&:to_s).join("\n")
    monsters_string = @monsters.map(&:to_s).join("\n")
    is_winner = finished
    GameState.new(labyrinth_string, players_string, monsters_string, @current_player_index, is_winner, @log)

  end
  private
  def configure_labyrinth
    5.times do
      row = Dice.random_pos(10)
      col = Dice.random_pos(10)
      monster_name = "Monster #(i + 1)"
      intelligence = Dice.random_intelligence
      strength = Dice.random_strength
      m = Monster.new(monster_name, intelligence, strength)
      @labyrinth.add_monster(row, col, m)
      @monsters << m
    end
  end
  def next_player
    @current_player_index += 1
    @current_player_index = 0 if @current_player_index >= @players.size
  end
  def actual_direction(preferred_direction)

  end
  def combat(monster)

  end
  def manage_reward(winner)

  end
  def manage_resurrection

  end
  def log_player_won
    @log += "The player has won the combat.\n"
  end

  def log_monster_won
    @log += "The monster has won the combat.\n"
  end

  def log_resurrected
    @log += "The player has resurrected.\n"
  end

  def log_player_skip_turn
    @log += "The player has skipped the turn due to being dead.\n"
  end

  def log_player_no_orders
    @log += "The player did not follow the human player's instructions.\n"
  end

  def log_no_monster
    @log += "The player moved to an empty cell or couldn't move.\n"
  end

  def log_rounds(rounds, max)
    @log += "#{rounds} out of #{max} combat rounds have occurred.\n"
  end
end
