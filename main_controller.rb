# frozen_string_literal: true
require_relative 'UI/textUI'
require_relative 'controller/controller'
require_relative 'Game'
module Irrgarten
  class TestP3
    def self.main
      game = Game.new(4,false)
      view = UI::TextUI.new
      c = Control::Controller.new(game,view)
      c.play
    end
  end
  Irrgarten::TestP3.main
end
