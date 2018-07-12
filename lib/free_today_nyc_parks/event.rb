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
      puts "URL:     https://www.nycgovparks.org/#{event.url}"
      puts ""
      puts "--------------------------"
      puts ""
    end
  end

  def self.filter_borough(borough)
    puts "Here are today's events in #{borough}:"
  end

  def self.filter_time(time)
    puts "Here are today's events starting from #{time}:"
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
