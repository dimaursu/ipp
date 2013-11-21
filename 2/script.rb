#!/usr/bin/env ruby

require 'gtk3'
require 'debugger'
require 'observer'
require 'singleton'

class Player
  attr_accessor :name, :health, :hits
  include Observable

  def initialize (name)
    # spawn a Gtk window
    window = Gtk::Window.new("#{name}'s window")
    button = Gtk::Button.new(label: "Hit someone")
    button.signal_connect("clicked") do
      @hits = @hits + 1
      changed
      notify_observers(@name, @hits)
    end
    window.add(button)
    window.show_all

    @name = name
    @health = 10
    @hits = 0
  end
end

class Scoreboard
  attr_accessor :score
  include Singleton
  include Observable

  def show_score
    Gui.instance.label.label = @score
  end

  def scorboardChange(scores)
    @score = scores.collect { |player, score| player.to_s + ":" + score.to_s } * "\n"
    show_score
  end
end

class Gui
  attr_accessor :label, :buttons
  include Singleton

  def initialize
    @builder = Gtk::Builder.new
    filename = File.join(File.dirname(__FILE__), "gui.glade")
    @builder << filename
    @builder.connect_signals {|name| method(name)}
    @window = @builder["MainWindow"]
    @label = @builder["label1"]
    @window.show_all
    @game = Observer.new
  end

  def on_add_player_clicked
    player = Player.new((0...8).map { (65 + rand(26)).chr }.join.capitalize)
    player.add_observer(@game)
  end
end

class Observer
  def initialize
    @scoreboard = Scoreboard.instance
    @scores = {}
  end

  def update(name, hits)
    @scores[name] = hits
    @scoreboard.scorboardChange(@scores)
  end
end

Gui.instance
Gtk.main
