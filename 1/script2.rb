#!/usr/bin/ruby

require 'gtk3'
class Gui
  def initialize
    @builder = Gtk::Builder.new
    filename = File.join(File.dirname(__FILE__), "proxy.glade")
    @builder << filename
    @builder.connect_signals {|name| method(name)}
    @window = @builder["MainWindow"]
    @window.show_all
  end

  def on_button1_clicked
    DownloaderProxy.get("http://some-shit.com")
  end

  def on_button2_clicked
    DownloaderProxy.get("http://some-shit.com")
  end

  def on_button3_clicked
    DownloaderProxy.get("http://some-shit.com")
  end

  def on_button4_clicked
  end

  def on_button5_clicked
    puts "a button was hitted"
  end

  def on_quit
    exit()
  end
end

class Downloader
  def self.get(links)
    threads = []
    links.each do |url|
      threads << Thread.new do
        file = URI.parse(url)
        File.write(file)
      end
    end
    threads.each.join
  end
end

Gui.new
Gtk.main

