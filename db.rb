require "sqlite3"

class Db
  DATABASE = "./nakanojyo.db"

  def initialize
    @db = SQLite3::Database.new(DATABASE)
  end

  def insert(hash)
    sql = "INSERT INTO news(link, href, timestamp) VALUES(?, ?, ?)"
    @db.execute(sql, hash['link'], hash['href'], hash['date'])
  end

  def exist?(link, timestamp)
    sql = "SELECT id FROM news WHERE link = ? AND timestamp = ?"
    count = @db.execute(sql, link, timestamp).length
    if count > 0
      true
    else
      false
    end
  end
end
