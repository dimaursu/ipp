#!/usr/bin/env ruby

require 'gtk3'
require 'open-uri'
require 'debugger'
class Gui
  def initialize
    @links = [  'http://www.oodesign.com/proxy-pattern.html',
                'http://d24w6bsrhbeh9d.cloudfront.net/photo/azb9xjp_700b_v1.jpg',
                'http://cartea-libera.info/dansurile/dansurile.pdf',
                'http://debian-handbook.info/download/stable/debian-handbook.pdf'
    ]
    @builder = Gtk::Builder.new
    filename = File.join(File.dirname(__FILE__), "proxy.glade")
    @builder << filename
    @builder.connect_signals {|name| method(name)}
    @window = @builder["MainWindow"]
    @window.show_all
  end

  def on_button1_clicked
    download(@links[0], "proxy.html")
  end

  def on_button2_clicked
    download(@links[1])
  end

  def on_button3_clicked
    download(@links[2])
  end

  def on_button4_clicked
    download(@links[3])
  end

  def on_button5_clicked
    puts "a button was hitted"
  end

  def on_quit
    exit()
  end

  def download(link, name)
    file = open(link)
    IO.copy_stream(file, "./tmp/#{name}")
  end
end

Gui.new
Gtk.main

