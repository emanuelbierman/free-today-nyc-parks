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
    self.all.each do |event|
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts "When:    #{event.start_time} - #{event.end_time}"
      puts "What:    #{event.description}"
      puts ""
      # puts "Cost:    #{event.cost}"
      puts "--------------------------"
      puts ""
      # puts event.time
      # puts event.description
      # puts event.url
    end
  end

  def self.filter_borough(borough)
    puts "Here are today's free events in #{borough}:"
  end

  def self.filter_time(time)
    puts "Here are today's free events starting from #{time}"
  end
end
