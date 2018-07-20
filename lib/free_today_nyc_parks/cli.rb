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
    FreeTodayNycParks::Event.print_all
  end

  def menu(array = FreeTodayNycParks::Event.all)
    puts "To learn more about an event, enter its number:"
    puts "Or you can view all (F)ree events:"
    puts "or filter events by (B)orough:"
    puts "or see the full (L)ist again, or (E)xit:"
    input = gets.strip
    if input.to_i != 0
      FreeTodayNycParks::Event.print_detail(input.to_i, array)
    else
      input = input.downcase[0]
      unless input == "e"
        if input == "f"
          FreeTodayNycParks::Event.filter_free
        elsif input == "b"
          FreeTodayNycParks::Event.filter_borough
        elsif input == "l"
          FreeTodayNycParks::Event.print_all
        end
      end
    end
  end

end
