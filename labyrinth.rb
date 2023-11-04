# frozen_string_literal: true

class Labyrinth
  @@BLOCK_CHAR =  'X'
  @@EMPTY_CHAR =  '-'
  @@MONSTER_CHAR =  'M'
  @@COMBAT_CHAR =  'C'
  @@EXIT_CHAR =  'E'
  @@ROW =  0
  @@COL = 1

  def initialize
    @nRows = nRows;
    @nCols = nCols;
    @exitRow = exitRow;
    @exitCol = exitCol;
    @labyrinth = Array.new(@nRows) {Array.new(@nCols, @@EMPTY_CHAR)}
    @monsters = Array.new(@nRows) {Array.new(@nCols)}
    @players = Array.new (@nRows) {Array.new (@nCols)}
    @labyrinth [@exitRow][@exitCol] = @@EXIT_CHAR
  end
  def spread_players(players)
    @players.each do |player|
      pos = random_empty_pos
      put_player_2d(-1, -1, pos[0], pos[1], player)
    end
  end
  def have_a_winner
    !@players[@exitRow][@exitCol].nil?
  end
  def to_s
    result = ""
    @labyrinth.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        result += if combat_pos(i, j)
                    @@COMBAT_CHAR
                  elsif monster_pos(i, j)
                    @@MONSTER_CHAR
                  else
                    cell
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
      @labyrinth[row][col] = @players[row][col] ? @@COMBAT_CHAR : @@MONSTER_CHAR
    end
  end
  def put_player(direction, player)
    old_row = player.row
    old_col = player.col
    new_pos = dir_2_pos(old_row, old_col, direction)
    monster = put_player_2d(old_row, old_col,new_pos[0],new_pos[1],player)
    monster
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
      length -= 1
    end
  end
  def valid_moves(row, col)
    output = []
    output << Directions::DOWN if can_step_on(row + 1, col)
    output << Directions::UP if can_step_on(row - 1, col)
    output << Directions::RIGHT if can_step_on(row, col + 1)
    output << Directions::LEFT if can_step_on(row, col - 1)
    output
  end
  private
  def pos_ok(row, col)
    row.between?(0, @nRows -1) && col.between?(0, @nCols - 1)
  end
  def empty_pos(row,col)
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
    pos_ok?(row,col) && [@labyrinth[row][col], monster_pos(row,col), exit_pos(row,col)].include?(@@EMPTY_CHAR)
  end
  def update_old_pos(row,col)
    if pos_ok?(row,col)
      @labyrinth[row][col] = @labyrinth[row][col] == @@COMBAT_CHAR ? @@MONSTER_CHAR : @@EMPTY_CHAR
    end
  end
  def dir_2_pos(row, col, direction)
    case direction
    when :UP
      row -= 1
    when :DOWN
      row += 1
    when :LEFT
      col -= 1
    when :RIGHT
      col += 1
    end
    [row, col]
  end

  def random_empty_pos
    loop do
      random_row = Dice.random_pos(@nRows)
      random_col = Dice.random_pos(@nCols)
      return [random_row, random_col] if @labyrinth[random_row][random_col] == @@EMPTY_CHAR
    end
  end
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
