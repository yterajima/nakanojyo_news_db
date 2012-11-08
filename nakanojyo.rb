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
            link = a.text.strip
            href = a['href'].strip
            if /^http:\/\// !~ href
              href = @base + href
            end

            if date && link && href
              @data.push({"date" => date, "link" => link, "href" => href})
            end
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
