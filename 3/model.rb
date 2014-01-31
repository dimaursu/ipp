require 'dbi'

class Model
  def initialze
    @dbh = DBI.connect("DBI:Mysql:test_db:localhost", "root", "nopass")
  end

  def get_row
    @dbh.execute("SELECT DISTINCT(headline),story,id FROM news")
  end

  def update_row(*args)
  end
end
