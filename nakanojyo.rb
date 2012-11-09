require "nokogiri"
require "open-uri"
require "date"

class Nakanojyo
  def initialize(mode = 'info')
    @base = "http://www.town.nakanojo.gunma.jp/~info/"
    if mode == 'info'
      @url  = @base + "shinchaku.html"
    else #topix
      @url  = @base + "chu_moku.html"
    end
    @data = Array.new
    self.get
  end

  def get
    begin
      @html = Nokogiri::HTML(open(@url))
    rescue
      @html = ""
    end
  end

  def parse
    if @html != ''
      @html.css('tr').each do |row|
        row.css('a').each do |a|
          begin
            date = Time.parse(row.css('font').text.strip).to_s.gsub(/ \+0900$/, '')
            date = date.strftime("%Y-%m-%d 00:00:00")
            link = a.text.strip
            href = a['href'].strip
            if /^http:\/\// !~ href
              href = @base + href
            end
            @data.push({"date" => date, "link" => link, "href" => href})
          rescue
            next
          end
        end
      end
      @data
    else
      nil
    end
  end
end
