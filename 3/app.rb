require 'rubygems'
require_relative 'controller'

if $0 == __FILE__ then
  server = WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => Dir::pwd + '/public')
  server.mount "/index", Controller
  trap "INT" do server.shutdown end
  server.start
end
