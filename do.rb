require "./nakanojyo"
require "./db"

town = Nakanojyo.new
data = town.parse
db   = Db.new

data.each do |hash|
  if !db.exist?(hash['link'], hash['date'])
    db.insert(hash)
  end
end
