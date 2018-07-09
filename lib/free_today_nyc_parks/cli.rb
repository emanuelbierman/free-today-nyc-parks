class FreeTodayNycParks::CLI

  @@boroughs = ["manhattan", "brooklyn", "bronx", "queens", "staten island"]

  def call
    start
  end

  def start
    puts ""
    puts "Every day there are free events happening all over NYC’s public parks."
    puts ""
    FreeTodayNycParks::Scraper.new.scrape
    FreeTodayNycParks::Event.print_list
    puts "You can view all (F)ree events, filter by (B)orough,"
    puts "filter by starting (T)ime, see the full (L)ist again, or (E)xit:"
    # puts "If you want to see only free events, type 'free':"
    # puts "If you want to refine your search by borough, type in the borough:"
    # puts "If you only want to see results starting from a certain time today, type in that time:"
    # puts "To repeat the list of events happening today, type 'list':"
    # puts "Otherwise, type 'exit':"
    input = gets.strip.downcase[0]
    unless input == "e"
      if input == "f"
        FreeTodayNycParks::Event.filter_free
      elsif input == "b"
        FreeTodayNycParks::Event.filter_borough(input)
      elsif input == "t"
        FreeTodayNycParks::Event.filter_time(input)
      elsif input == "l"
        FreeTodayNycParks::Event.print_list
      end
    end
  end

end
