#!/usr/bin/env ruby

require 'gtk3'
require 'debugger'
require 'observer'
require 'singleton'

class Player
  attr_accessor :name, :health, :hits
  include Observable
  $players ||= []

  def initialize (name)
    notifier = Notifier.instance
    add_observer(notifier)
    # spawn a Gtk window
    window = Gtk::Window.new("#{name}'s window")
    button = Gtk::Button.new(label: "Hit someone")
    button.signal_connect("clicked") do
      changed
      @hits = @hits + 1
      notify_observers($players)
    end
    window.add(button)
    window.show_all

    @name = name
    @health = 10
    @hits = 0
    $players << self
  end
end

class Scoreboard
  attr_accessor :score
  include Singleton

  def initialize
    @score = "0:0"
  end

  def show_score(label)
    label.label = @score
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
  end

  def on_add_player_clicked
    Player.new((0...8).map { (65 + rand(26)).chr }.join.capitalize)
  end
end

class Notifier
  include Singleton

  def initialize
    @players = []
  end

  def update(player)
    puts @players.count
  end
end

Gui.instance
Gtk.main
