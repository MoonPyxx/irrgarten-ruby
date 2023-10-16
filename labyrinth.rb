# frozen_string_literal: true

class Labyrinth
  @@BLOCK_CHAR =  'X'
  @@EMPTY_CHAR =  '-'
  @@MONSTER_CHAR =  'M'
  @@COMBAT_CHAR =  'C'
  @@EXIT_CHAR =  'E'
  @@ROW =  0
  @@COL = 1
  attr_accessor :nRows, :nCols, :exitRow, :exitCol

  def initialize
    @nRows = nRows;
    @nCols = nCols;
    @exitRow = exitRow;
    @exitCol = exitCol;
  end
  def spread_players(players)

  end
  def have_a_winner

  end
  def to_string

  end
  def add_monster(row,col,monster)

  end
  def put_player(direction, player)

  end
  def add_block(orientation, start_row, start_col, length)

  end
  def valid_moves(row, col)

  end
  private
  def pos_ok(row, col)

  end
  def empty_pos(row,col)

  end
  def monster_pos(row, col)

  end
  def exit_pos(row, col)

  end
  def combat_pos(row,col)

  end
  def can_step_on(row,col)

  end
  def update_old_pos(row,col)

  end
  def dir_2_pos(row, col, direction)

  end
  def random_empty_pos

  end
  def put_player_2d(oldRow, oldCol, row, col, player)

  end

end
