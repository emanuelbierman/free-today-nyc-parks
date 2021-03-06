class FreeTodayNycParks::Scraper

  def scrape
    doc = Nokogiri::HTML(open("https://www.nycgovparks.org/events"))

    doc.css("div#events_leftcol h3 a").each do |title|
      FreeTodayNycParks::Event.new(title.content)
    end

    today = doc.css("div#events_leftcol h2")[0].text
    FreeTodayNycParks::Event.today=(today)

    descriptions = []
    doc.css("div#events_leftcol div span.description").each {|s| descriptions << s.text }

    urls = []
    doc.css("div#events_leftcol h3 a").each {|s| urls << "https://www.nycgovparks.org" + s["href"] }

    locations = []
    boroughs = []
    doc.css("div#events_leftcol div h4.location").each do |s|
      locations << s.text
      boroughs << s.css("span")[2].text.downcase
    end

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

    FreeTodayNycParks::Event.all.each_with_index do |event, index|
      event.start_time = start_times[index]
      event.end_time = end_times[index]
      event.location = locations[index]
      event.borough = boroughs[index]
      event.description = descriptions[index]
      event.cost = free_or_nil[index]
      event.url = urls[index]
    end
  end
end
