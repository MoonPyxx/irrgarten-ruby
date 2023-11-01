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

  end
  def add_block(orientation, start_row, start_col, length)

  end
  def valid_moves(row, col)

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
  def put_player_2d(oldRow, oldCol, row, col, player)

  end

end
