#!/usr/bin/env ruby

require 'gtk3'
require 'debugger'

class Mediator
  attr_accessor :label
  attr_accessor :buttons

  def initialize
    @builder = Gtk::Builder.new
    filename = File.join(File.dirname(__FILE__), "gui.glade")
    @builder << filename
    @builder.connect_signals {|name| method(name)}
    @window = @builder["MainWindow"]
    @label = @builder["label1"]
    @buttons = []
    @buttons.push(@builder["hit"], @builder["hith"])
    @window.show_all
    @player1 = Player.new("Ion")
    @player2 = Player.new("Dima")
    @scoreboard = Scoreboard.new
  end

  def on_p1button_clicked
    @player1.hits += 1
  end

  def on_p2button_clicked
    @player2.hits += 1
  end

  def run
    while true do
      if (@player1.hits >= @player2.health) || (@player2.hits >= @player1.health)
        @scoreboard.score = "#{@player1.hits}:#{@player2.hits} Game over"
        @scoreboard.show_score(@label)
        sleep(2)
        @window.destroy
      else
        @scoreboard.score = "#{@player1.hits}:#{@player2.hits}"
        @scoreboard.show_score(@label)
      end
    end
  end
end

class Player
  attr_accessor :name
  attr_accessor :health
  attr_accessor :hits

  def initialize (name)
    @name = name
    @health = 10
    @hits = 0
  end
end

class Scoreboard
  attr_accessor :score

  def initialize
    @score = "0:0"
  end

  def show_score(label)
    label.label = @score
  end
end

m = Mediator.new
Thread.new { Gtk.main }
m.run
