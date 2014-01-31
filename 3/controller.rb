require 'webrick'
require './model.rb'
require './view.rb'

class Controller < WEBrick::HTTPServlet::AbstractServlet

  def initialze
    view = View.new
    model = Model.new
  end

    def do_GET(request, response)
    status, content_type, body = print_questions(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def print_questions(request)
    html   = "<html><body><form method='POST' action='/save'>"
    html += "Name: <input type='textbox' name='first_name' /><br /><br />";

    html += "<input type='submit'></form></body></html>"
    return 200, "text/html", html
  end
end

