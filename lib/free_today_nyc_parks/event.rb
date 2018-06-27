class FreeTodayNycParks::Event

  attr_accessor :title, :borough, :location, :time, :description, :url

  @@all = []

  def initialize(title)
    @title = title
    @@all << self
  end

  def self.all
    @@all
  end

  def self.print_list
    # use heredocs to format this list?
    self.all.each do |event|
      puts "    #{event.title}"
      # puts event.location
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
