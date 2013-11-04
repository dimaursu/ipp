#!/usr/bin/env ruby

require 'gtk3'
require 'open-uri'
require 'debugger'
class Gui
  def initialize
    @links = [  'http://www.oodesign.com/proxy-pattern.html',
                'http://d24w6bsrhbeh9d.cloudfront.net/photo/azb9xjp_700b_v1.jpg',
                'http://cartea-libera.info/dansurile/dansurile.pdf',
                'http://debian-handbook.info/download/stable/debian-handbook.pdf',
                'http://foundation.zurb.com/docs/components/forms.html'
    ]
    @builder = Gtk::Builder.new
    filename = File.join(File.dirname(__FILE__), "proxy.glade")
    @builder << filename
    @builder.connect_signals {|name| method(name)}
    @window = @builder["MainWindow"]
    @spinner = @builder['spinner1']
    @window.show_all
    @proxy = DownloaderProxy.new
  end

  def on_button1_clicked
    download(@links[0])
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
    download(@links[4])
  end

  def on_quit
    exit()
  end

  def download(link)
    @spinner.start
    @proxy.get(link)
    @spinner.stop
  end
end

class DownloaderProxy
  def initialize
    @links = []
    @downloader = Downloader.new
  end

  def get(link)
    @links << link
    if @links.count == 5
      puts @links.count
      @links.each { |link| @downloader.get(link) }
    end
  end
end

class Downloader
  def get(link)
    file = open(link)
    IO.copy_stream(file, "./tmp/#{link.match(/([^\/]+)$/)}")
  end
end

Gui.new
Gtk.main

