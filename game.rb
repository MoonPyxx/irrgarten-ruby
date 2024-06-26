# frozen_string_literal: true
require_relative 'GameCharacter'
require_relative 'Dice'
require_relative 'player'
require_relative 'labyrinth'
require_relative 'monster'
require_relative 'game_state'
require_relative 'Orientation'
require_relative 'fuzzy_player'
module Irrgarten
class Game
  @@MAX_ROUNDS = 10
  # consultor de current_player para pruebas en main_automatico
  attr_reader :current_player, :labyrinth
  def initialize(n_players,debug)
    @players = []
    @monsters = []
    @log = ""
    if (debug)
      @current_player_index =  0
      n_players.times do |i|
      intelligence = 5
      strength = 5
      @players << Player.new((i.to_s + '0').chr, intelligence,strength)
      end
      exit_row = 9
      exit_col = 9
      @labyrinth = Irrgarten::Labyrinth.new(10,10,exit_row,exit_col)
      configure_labyrinth_debug
    else
      @current_player_index = Dice.who_starts(n_players)
      n_players.times do |i|
        intelligence = Dice.random_intelligence
        strength = Dice.random_strength
        @players << Player.new((i.to_s + '0').chr, intelligence, strength)
      end
      exit_row = Dice.random_pos(10)
      exit_col = Dice.random_pos(10)
      @labyrinth = Irrgarten::Labyrinth.new(10,10,exit_row, exit_col)
      configure_labyrinth
    end
    @current_player = @players[@current_player_index]
    end
  def finished
    @labyrinth.have_a_winner
  end
  def next_step(preferred_direction)
    @log = ""
    dead = @current_player.dead
    if !dead
      direction = actual_direction(preferred_direction)
      if direction != preferred_direction
        log_player_no_orders
      end
      monster = @labyrinth.put_player(direction, @current_player)
      if monster.nil?
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
    players_string = ""
    monsters_string = ""
    @players.each do |p|
      players_string += p.to_string + "\n"
    end
    @monsters.each do |m|
      monsters_string += m.to_string + "\n"
    end
    labyrinth_string= @labyrinth.to_s
    is_winner = finished
    Irrgarten::GameState.new(labyrinth_string, players_string, monsters_string, @current_player_index, is_winner, @log)

  end
  private
  def configure_labyrinth
    num_blocks = 5
    num_monsters = 10
    i = 0
    num_blocks.times do
      row = Dice.random_pos(10)
      col = Dice.random_pos(10)
      length = 2
      @labyrinth.add_block(Orientation::VERTICAL,row,col,length)
      end
    num_monsters.times do
      row = Dice.random_pos(10)
      col = Dice.random_pos(10)
      monster_name = "Monster #{i+1}"
      intelligence = Dice.random_intelligence
      strength = Dice.random_strength
      m = Monster.new(monster_name, intelligence, strength)
      m.set_pos(row,col)
      @labyrinth.add_monster(row, col, m)
      @monsters << m
      i = i+1
    end
    @labyrinth.spread_players(@players)
  end
def configure_labyrinth_debug
  num_blocks = 2
  # num_monsters = 2
  i = 0
  num_blocks.times do
    row = i+1
    col = i+1
    length = 2
    @labyrinth.add_block(Orientation::VERTICAL,row,col,length)
    i = i+1
  end
    m1 = Monster.new("Monster 1", 10, 15)
    m1.set_pos(5,5)
    @labyrinth.add_monster(5, 5, m1)
    @monsters << m1
  m2 = Monster.new("Monster 2", 6, 6)
  m2.set_pos(6,6)
  @labyrinth.add_monster(6, 6, m2)
  @monsters << m2
  @labyrinth.spread_players_debug(@players)
end
  def next_player
    @current_player_index += 1
    @current_player_index = 0 if @current_player_index >= @players.size
    @current_player = @players[@current_player_index]
  end
  def actual_direction(preferred_direction)
    current_row = @current_player.row
    current_col = @current_player.col
    valid_moves = @labyrinth.valid_moves(current_row,current_col)
    @current_player.move(preferred_direction, valid_moves)
  end
  def combat(monster)
    rounds = 0
    winner = GameCharacter::PLAYER
    player_attack = @current_player.attack
    lose = monster.defend(player_attack)
    while !lose && rounds < @@MAX_ROUNDS
      rounds = rounds + 1
      winner = GameCharacter::MONSTER
      monster_attack = monster.attack
      lose = @current_player.defend(monster_attack)

      unless lose
        player_attack = @current_player.attack
        winner = GameCharacter::PLAYER
        lose = monster.defend(player_attack)
      end
    end
    log_rounds(rounds, @@MAX_ROUNDS)
    winner
  end

  def manage_reward(winner)
    if winner == GameCharacter::PLAYER
      @current_player.receive_reward
      log_player_won
    else
      log_monster_won
    end
  end
  def manage_resurrection
    resurrect = Dice.resurrect_player
    if resurrect
      @current_player.resurrect
      # resurrect_fuzzy=Dice.resurrect_player
      #  if resurrect_fuzzy
        new_fuzzy_player = FuzzyPlayer.new(@current_player)
        @players[@current_player_index] = new_fuzzy_player
        @current_player = new_fuzzy_player
        log_resurrected_fuzzy
      # else
      #log_resurrected
      #s end
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
  def log_resurrected_fuzzy
    @log += "The player has resurrected as a fuzzy player.\n"
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