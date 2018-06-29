class FreeTodayNycParks::Event

  attr_accessor :title, :borough, :location, :time, :description, :url

  @@all = []
  @@today = nil

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

  def self.print_list
    # use heredocs to format this list?
    puts "Here are the events for #{self.today}:"
    self.all.each do |event|
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts ""
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
