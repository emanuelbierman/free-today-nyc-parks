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
    menu
  end

  def menu
    puts "To learn more about an event, enter its number:"
    puts "Or you can view all (F)ree events,"
    puts "or filter events by (B)orough or by starting (T)ime,"
    puts "or see the full (L)ist again, or (E)xit:"
    input = gets.strip
    if input.to_i != 0
      FreeTodayNycParks::Event.print_detail(input.to_i)
      menu
    else
      input = input.downcase[0]
      unless input == "e"
        if input == "f"
          FreeTodayNycParks::Event.filter_free
          menu
        elsif input == "b"
          FreeTodayNycParks::Event.select_borough
          menu
        elsif input == "t"
          FreeTodayNycParks::Event.select_time
          menu
        elsif input == "l"
          FreeTodayNycParks::Event.print_list
          menu
        end
      end
    end
  end

end
