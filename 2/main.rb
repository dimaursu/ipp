#!/usr/bin/env ruby

require 'gtk2'
require 'yaml'
require_relative 'my_classes'
require_relative 'checkbox'

PizzaAdriano.new(Gtk::Window::TOPLEVEL)
Gtk.main
