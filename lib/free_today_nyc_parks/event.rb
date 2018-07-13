class FreeTodayNycParks::Event

  attr_accessor :title, :borough, :location, :start_time, :end_time, :cost, :description, :url

  @@all = []
  @@today = nil
  @@tomorrow = nil

  def initialize(title)
    @title = title
    @@all << self
  end

  def self.all
    @@all
  end

  def self.today=(today)
    @@today = today
  end

  def self.today
    @@today
  end

  def self.tomorrow=(tomorrow)
    @@tomorrow = tomorrow
  end

  def self.tomorrow
    @@tomorrow unless @@tomorrow == nil
  end

  def self.print_list
    # use heredocs to format this list?
    puts "Here are the events for #{self.today}:"
    puts ""
    self.all.each do |event|
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
  end

  def self.borough(input)

  end

  def self.filter_borough
    puts "Enter (M, Q, BR, BX, SI) to see a list of events in that borough,"
    puts "or (C)ancel or (E)xit"
    input = gets.chomp
    puts "Here are today's events in #{borough}:"
    unless input == "e"
      self.borough(input).each do
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
    end
  end

  def self.time(input)

  end

  def self.filter_time
    puts "Enter a (12-hour)time to see a list of events starting from that time,"
    puts "or (c)ancel or (c)xit"
    input = gets.chomp[0].to_i
    puts "Here are today's events starting from #{time}:"
    unless input == "e"
      self.time(input).each do
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
    end
  end

  def self.free
    self.all.select do |event|
      event.cost == "Free!"
    end
  end

  def self.filter_free
    puts "Here are today's free events:"
    puts ""
    self.free.each do |event|
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
  end

end
