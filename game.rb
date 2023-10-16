# frozen_string_literal: true

class Game
  @@MAX_ROUNDS = 10

  attr_accessor :currentPlayerIndex, :log
  def initialize(nplayers)
    @currentPlayerIndex = 0
    @log = ""
  end

  def finished

  end
  def next_step(preferred_direction)

  end
  def get_game_state

  end
  private
  def configure_labyrinth

  end
  def next_player

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

  end
  def log_monster_won

  end
  def log_resurrected

  end
  def log_player_skip_turrn

  end
  def log_player_no_orders

  end
  def log_no_monster

  end
  def log_rounds(rounds, max)

  end

end
