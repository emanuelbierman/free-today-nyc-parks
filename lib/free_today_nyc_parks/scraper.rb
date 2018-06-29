require 'nokogiri'
require 'open-uri'

class FreeTodayNycParks::Scraper

  def scrape
      doc = Nokogiri::HTML(open("https://www.nycgovparks.org/events"))
      doc.css("div#events_leftcol h3 a").each do |title|
        FreeTodayNycParks::Event.new(title.content)
      end

      today = doc.css("div#events_leftcol h2").text
      FreeTodayNycParks::Event.today=(today)

      array_of_locations = @doc.css("div#events_leftcol div h4.location span").text.split(", ")

      locations = []
      doc.css("div#events_leftcol div h4.location span").each {|e| locations << e.text }

      one_location = doc.css("div#events_leftcol div h4.location span")[0].text

  end

end
