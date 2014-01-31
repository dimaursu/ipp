class View
  def index
    File.open('web_docs/search.rhtml','r') do |f|
    @template = ERB.new(f.read)
    end
    response.body = @template.result(binding)
    response['Content-Type'] = "text/html"
  end
end


