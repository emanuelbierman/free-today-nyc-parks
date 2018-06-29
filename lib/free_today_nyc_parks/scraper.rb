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

      locations = []
      doc.css("div#events_leftcol div h4.location span").each {|e| locations << e.text unless e.text.start_with?(",") }

      # locations.each_with_index do |loc|
      #
      # end

      FreeTodayNycParks::Event.all.each_with_index do |event, index|
        event.location = locations[index]
      end

  end

end
