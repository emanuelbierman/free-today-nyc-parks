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

      descriptions = []
      doc.css("div#events_leftcol div span.description").each {|s| descriptions << s.text }

      FreeTodayNycParks::Event.all.each_with_index do |event, index|
        event.description = descriptions[index]
      end

      locations = []
      doc.css("div#events_leftcol div h4.location span").each {|s| locations << s.text unless s.text.start_with?(",") }

      FreeTodayNycParks::Event.all.each_with_index do |event, index|
        event.location = locations[index]
      end

      # start_times = []
      # @doc.css("div#events_leftcol div").each do |d|
      #   start_times << d.css("p strong")[0]
      # end
      # start_times.select {|e| e.class == String }
      # ==> ["9:00 a.m."]

      # doc.css("div#events_leftcol div")[0].css("p strong")[0].text
      # ==> "9:00 a.m."


  end

end
