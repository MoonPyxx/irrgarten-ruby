# frozen_string_literal: true
require_relative 'Orientation'
module Irrgarten
class Labyrinth
  @@BLOCK_CHAR =  'X'
  @@EMPTY_CHAR =  '-'
  @@MONSTER_CHAR =  'M'
  @@COMBAT_CHAR =  'C'
  @@EXIT_CHAR =  'E'
  @@ROW =  0
  @@COL = 1

  def initialize(n_rows, n_cols, exit_row, exit_col)
    @n_rows = n_rows;
    @n_cols = n_cols;
    @exit_row = exit_row;
    @exit_col = exit_col;
    @labyrinth = Array.new(@n_rows) {Array.new(@n_cols, @@EMPTY_CHAR)}
    @monsters = Array.new(@n_rows) {Array.new(@n_cols)}
    @players = Array.new (@n_rows) {Array.new (@n_cols)}
    @labyrinth [@exit_row][@exit_col] = @@EXIT_CHAR
  end
  def spread_players(players)
    players.each do |player|
      pos = random_empty_pos
      put_player_2d(-1, -1, pos[0], pos[1], player)
    end
  end
  def spread_players_debug(players)
    #i = 0
    # asignar jugadores automaticamente, como lo voy a asignar manualmente no hace falta
    # players.each do |player|
    # row = i+1
    # col = i+2
    #  pos = [row,col]
    player0  = players[0]
    player1 = players[1]
      put_player_2d(-1, -1, 5, 6, player0)
      put_player_2d(-1, -1, 6, 5, player1)
    # i = i+1
  end
  def have_a_winner
    !@players[@exit_row][@exit_col].nil?
  end
  def to_s
    result = ""
    @n_rows.times do |i|
      @n_cols.times do |j|
        if combat_pos(i, j)
          result += @@COMBAT_CHAR
        elsif monster_pos(i, j)
          result += @@MONSTER_CHAR
        else
          result += @labyrinth[i][j]
        end
        result += ' '
      end
      result += "\n"
    end
    result
  end
  def add_monster(row,col,monster)
    if can_step_on(row, col)
      @monsters[row][col] = monster
      if @players[row][col].nil?
        @labyrinth[row][col] = @@MONSTER_CHAR
      else
        @labyrinth[row][col] = @@COMBAT_CHAR
      end
    end
  end
  def put_player(direction, player)
    old_row = player.row
    old_col = player.col
    new_pos = dir_2_pos(old_row, old_col, direction)
    monster = put_player_2d(old_row, old_col, new_pos[0], new_pos[1], player)
  end
  def add_block(orientation, start_row, start_col, length)
    inc_row = 0
    inc_col = 0
    if orientation == Orientation::VERTICAL
      inc_row = 1
    else
      inc_col = 1
    end
    row = start_row
    col = start_col

    while pos_ok(row,col) && empty_pos(row,col) && length > 0
      @labyrinth[row][col] = @@BLOCK_CHAR
      row += inc_row
      col += inc_col
      length = length - 1
    end
  end
  def valid_moves(row, col)
    output = []
    if can_step_on(row + 1,col)
      output << Directions::DOWN
    end
    if can_step_on(row - 1, col)
      output << Directions::UP
    end
    if can_step_on(row, col + 1)
      output << Directions::RIGHT
    end
    if can_step_on(row, col - 1)
      output << Directions::LEFT
    end
    output
  end
  private
  def pos_ok(row, col)
     row >= 0 && row < @n_rows && col >= 0 && col < @n_cols
  end
  def empty_pos(row,col)
    if !pos_ok(row,col)
      false
    end
    @labyrinth[row][col] == @@EMPTY_CHAR && @players[row][col].nil? && @monsters[row][col].nil?
  end
  def monster_pos(row, col)
    !@monsters[row][col].nil?
  end
  def exit_pos(row, col)
  @labyrinth[row][col] == @@EXIT_CHAR
  end
  def combat_pos(row,col)
    !@monsters[row][col].nil? && !@players[row][col].nil?
  end
  def can_step_on(row,col)
    pos_ok(row,col) && (@labyrinth[row][col] == @@EMPTY_CHAR || monster_pos(row,col) || exit_pos(row,col))
  end
  def update_old_pos(row,col)
    if pos_ok(row,col)
      if @labyrinth[row][col] == @@COMBAT_CHAR
        @labyrinth[row][col] = @@MONSTER_CHAR
      else
        @labyrinth[row][col] = @@EMPTY_CHAR
      end
    end
  end
  def dir_2_pos(row, col, direction)
    case direction
    when Directions::UP
      row = row-1
    when Directions::DOWN
      row = row + 1
    when Directions::LEFT
      col = col -1
    when Directions::RIGHT
      col = col+1
    end
    [row, col]
  end

  def random_empty_pos
    random_row, random_col = 0,0
    loop do
      random_row = Dice.random_pos(@n_rows)
      random_col = Dice.random_pos(@n_cols)
      break if @labyrinth[random_row][random_col] == @@EMPTY_CHAR
    end
    [random_row, random_col]
  end
  public #para poder mover a un jugador en main_automatico
  def put_player_2d(old_row, old_col, row, col, player)
    output = nil
    if can_step_on(row,col)
      if pos_ok(old_row,old_col)
        p = @players[old_row][old_col]
        if p == player
          update_old_pos(old_row,old_col)
          @players[old_row][old_col] = nil
        end
      end
      monster_pos = monster_pos(row,col)
      if monster_pos
        @labyrinth[row][col] = @@COMBAT_CHAR
        output = @monsters[row][col]
      else
        number = player.number
        @labyrinth[row][col] = number
      end
      @players[row][col] = player
      player.set_pos(row,col)
    end
    output
  end
end
end
