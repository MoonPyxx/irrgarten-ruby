# frozen_string_literal: true
require_relative 'textUI'
require_relative 'controller'
require_relative 'Game'
module Irrgarten
  class TestP3
    def self.main
      game = Game.new(2,false)
      view = UI::TextUI.new
      c = Control::Controller.new(game,view)do
      end
      c.play
    end
  end
  Irrgarten::TestP3.main
end
