require 'nokogiri'
require 'open-uri'

class FreeTodayNycParks::Scraper

  def scrape
      doc = Nokogiri::HTML(open("https://www.nycgovparks.org/events"))
      doc.css("div#events_leftcol h3 a").each do |title|
        FreeTodayNycParks::Event.new(title.content)
      end

      today = doc.css("div#events_leftcol h2")[0].text
      FreeTodayNycParks::Event.today=(today)

      # if doc.css("div#events_leftcol h2")[1].text != nil
      #   tomorrow = doc.css("div#events_leftcol h2")[1].text
      #   FreeTodayNycParks::Event.tomorrow=(tomorrow)
      # end

      start_times = []
      end_times = []
      free_or_nil = []
      doc.css("div#events_leftcol div.row").each do |n|
        start_times << n.css("p strong")[0].text
        end_times << n.css("p strong")[1].text
        if n.css("p strong")[3] == nil
          free_or_nil << "May have a nominal fee; see event url for more details"
        else
          free_or_nil << n.css("p strong")[3].text
        end
      end

      # "consult event url for more information on cost"

      locations = []
      doc.css("div#events_leftcol div h4.location span").each {|s| locations << s.text unless s.text.start_with?(",") }

      descriptions = []
      doc.css("div#events_leftcol div span.description").each {|s| descriptions << s.text }

      FreeTodayNycParks::Event.all.each_with_index do |event, index|
        event.start_time = start_times[index]
        event.end_time = end_times[index]
        event.location = locations[index]
        event.description = descriptions[index]
        event.cost = free_or_nil[index]
      end


      # start_times = []
      # end_times = []
      # @doc.css("div#events_leftcol div").each do |d|
      #   start_times << d.css("p strong")[0]
      #   end_times << d.css("p strong")[1]
      # end

      # doc.css("div#events_leftcol div h4.location")[0].next.next.next.css("strong").text
      # => "7:00 a.m.8:30 p.m.Category: Free!"

      # start_times.select {|e| e.class == String }
      # ==> ["9:00 a.m."]

      # start_times.each {|n| puts n.text unless n == nil }

      # doc.css("div#events_leftcol div")[0].css("p strong")[0].text
      # ==> "9:00 a.m."

      # start_times = []
      # doc.css("div#events_leftcol div").each {|d| start_times << d.css("p strong")[0] }

  end

end
