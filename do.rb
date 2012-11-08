require "./nakanojyo"
require "./db"

db   = Db.new

news = Nakanojyo.new('info').parse
news.each do |hash|
  if !db.exist?(hash['link'], hash['date'])
    db.insert(hash)
  end
end

topix = Nakanojyo.new('topix').parse
topix.each do |hash|
  if !db.exist?(hash['link'], hash['date'])
    db.insert(hash)
  end
end
