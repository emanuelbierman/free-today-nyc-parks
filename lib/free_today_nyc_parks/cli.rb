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
    print_all
  end

  def menu(array = FreeTodayNycParks::Event.all)
    puts "To learn more about an event, enter its number:"
    puts "Or you can view all (F)ree events:"
    puts "or filter events by (B)orough:"
    puts "or see the full (L)ist again, or (E)xit:"
    input = gets.strip
    if input.to_i != 0
      print_detail(input.to_i, array)
    else
      input = input.downcase
      unless input == "e" || input == "exit"
        if input == "f" || input == "free"
          filter_free
        elsif input == "b" || input == "borough"
          filter_borough
        elsif input == "l" || input == "list"
          print_all
        else
          puts ""
          puts "Please enter a valid command."
          puts ""
          menu
        end
      end
    end
  end

  def filter_borough
    puts "Enter a borough (Manhattan, Bronx, etc):"
    puts "or return to the full (L)ist:"
    input = gets.chomp.downcase
    if input == "l"
      FreeTodayNycParks::Event.print_all
    elsif FreeTodayNycParks::Event.select_borough(input) == []
      puts ""
      puts "There are no remaining events in #{input.capitalize} for today."
      puts ""
      FreeTodayNycParks::Event.filter_borough
    else
      puts ""
      puts "Here are today's events in #{input.capitalize}:"
      puts ""
      selected_boroughs = FreeTodayNycParks::Event.select_borough(input)
      selected_boroughs.each_with_index do |event, index|
        puts "#{index + 1}"
        puts "What:    #{event.title}"
        puts "Where:   #{event.location}"
        puts "When:    #{event.start_time} - #{event.end_time}"
        puts ""
        puts "--------------------------"
        puts ""
      end
      menu(selected_boroughs)
    end
  end

  def filter_free
    puts "Here are today's free events:"
    puts ""
    FreeTodayNycParks::Event.free.each_with_index do |event, index|
      puts "#{index + 1}"
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts "When:    #{event.start_time} - #{event.end_time}"
      puts ""
      puts "--------------------------"
      puts ""
    end
    menu(FreeTodayNycParks::Event.free)
  end

  def print_all
    puts "Here are the events for #{FreeTodayNycParks::Event.today}:"
    puts ""
    FreeTodayNycParks::Event.all.each_with_index do |event, index|
      puts "#{index + 1}"
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts "When:    #{event.start_time} - #{event.end_time}"
      puts ""
      puts "--------------------------"
      puts ""
    end
    menu
  end

  def detail(event)
    puts ""
    puts "What:    #{event.title}"
    puts "Where:   #{event.location}"
    puts "When:    #{event.start_time} - #{event.end_time}"
    puts "What:    #{event.description}"
    puts "Cost:    #{event.cost}"
    puts "URL:     #{event.url}"
    puts ""
    puts "--------------------------"
    puts ""
  end

  def print_detail(input, array = FreeTodayNycParks::Event.all)
    if input.between?(1, array.size)
      array.each_with_index do |event, index|
        if input == (index + 1)
          detail(event)
        end
      end
    else
      puts ""
      puts "Please enter a number from 1 to #{array.size}."
      puts ""
    end
    menu(array)
  end

end
