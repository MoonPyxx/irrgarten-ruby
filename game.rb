# frozen_string_literal: true
require_relative 'GameCharacter'
require_relative 'Dice'
require_relative 'Player'
require_relative 'Labyrinth'
require_relative 'Monster'
require_relative 'Game_state'
module Irrgarten
class Game
  @@MAX_ROUNDS = 10
  def initialize(n_players)
    @current_player_index = Dice.who_starts(n_players)
    @players = []
    @monsters = []
    @log = ""

    n_players.times do |i|
      intelligence = Dice.random_intelligence
      strength = Dice.random_strength
      @players << Player.new((i.to_s + '0').chr, intelligence, strength)
    end

    @current_player_index = Dice.who_starts(n_players)
    exit_row = Dice.random_pos(10)
    exit_col = Dice.random_pos(10)
    @labyrinth = Irrgarten::Labyrinth.new(10,10,exit_row, exit_col)
    configure_labyrinth
  end

  def finished
    @labyrinth.have_a_winner
  end
  def next_step(preferred_direction)
    current_player = @players[@current_player_index]
    dead = current_player.dead
    if !dead
      direction = actual_direction(preferred_direction)
      if (direction != preferred_direction)
        log_player_no_orders
      end
      monster = @labyrinth.put_player(direction, current_player)
      if (monster.nil?)
        log_no_monster
      else
        winner = combat(monster)
        manage_reward(winner)
      end
    else
      manage_resurrection
    end
    end_game = finished
    if !end_game
      next_player
    end
    end_game
  end
  def get_game_state
    labyrinth_string= @labyrinth.to_s
    players_string = @players.map(&:to_s).join("\n")
    monsters_string = @monsters.map(&:to_s).join("\n")
    is_winner = finished
    Irrgarten::GameState.new(labyrinth_string, players_string, monsters_string, @current_player_index, is_winner, @log)

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
    current_player = @players[@current_player_index]
    current_row = current_player.row
    current_col = current_player.col
    valid_moves = @labyrinth.valid_moves(current_row,current_col)
    current_player.move(preferred_direction, valid_moves)
    valid_moves.each do |valid_move|
      return preferred_direction if valid_move == preferred_direction
    end

    nil
  end
  def combat(monster)
    current_player = @players[@current_player_index]
    rounds = 0
    winner = GameCharacter::PLAYER
    lose = false
    while (!lose && rounds < @@MAX_ROUNDS)
      player_attack = current_player.attack
      lose = monster.defend(player_attack)

      if !lose
        monster_attack = monster.attack
        lose = current_player.defend(monster_attack)
        winner = GameCharacter::MONSTER if lose
      end

      rounds +=1
    end

    log_rounds(rounds, @@MAX_ROUNDS)
    winner

  end
  def manage_reward(winner)
    current_player = @players[@current_player_index]
    if winner == GameCharacter::PLAYER
      current_player.receive_reward
      log_player_won
    else
      log_monster_won
    end
  end
  def manage_resurrection
    current_player = @players[@current_player_index]
    resurrect = Dice.resurrect_player
    if (resurrect)
      current_player.resurrect
      log_resurrected
    else
      log_player_skip_turn
    end
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
end