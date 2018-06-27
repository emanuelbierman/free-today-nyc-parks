class FreeTodayNycParks::CLI

  @@boroughs = [manhattan, brooklyn, bronx, queens, staten island]

  def call
    start
  end

  def start
    puts "Welcome to Free Today in NYC!"
    puts "Every day there are free events happening all over NYC’s public parks."
    puts ""
    puts "Here are the events happening today:"
    Free_NYC::Scraper.new.scrape
    Free_NYC::Event.print_list
    puts "If you want to refine your search by borough, type in the borough:"
    puts "If you only want to see results starting from a certain time today, type in that time:"
    puts "To repeat the list of events happening today, type 'list':"
    puts "Otherwise, type 'exit':"
    input = gets.strip.downcase
    while input != "exit"
      if input == "list"
        Free_NYC::Event.print_list
      elsif input.to_i.between?(0,24)
        Free_NYC::Event.filter_date(input)
      elsif @@boroughs.include?(input)
        Free_NYC::Event.all.filter_borough(input)
      end
    end
  end

end
