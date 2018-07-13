require 'pry'

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
    self.all.each_with_index do |event, index|
      puts "#{index}"
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts "When:    #{event.start_time} - #{event.end_time}"
      puts ""
      puts "--------------------------"
      puts ""
    end
  end

  def print_detail
    puts ""
    puts "What:    #{self.title}"
    puts "Where:   #{self.location}"
    puts "When:    #{self.start_time} - #{self.end_time}"
    puts "What:    #{self.description}"
    puts "Cost:    #{self.cost}"
    puts "URL:     #{self.url}"
    puts ""
    puts "--------------------------"
    puts ""
  end

  def self.select_detail(input)
    self.all.each_with_index do |event, index|
      if input == index
        event.print_detail
      end
    end
  end

  def self.search_borough(input)
    input = input.split(", ")

    boroughs = self.all.select do |event|
      event.borough == input[0] || event.borough == input[1]
    end

    if boroughs != nil
      boroughs
    else
      puts ""
      puts "There are no remaining events in #{input.capitalize} for today."
      puts ""
    end
  end

  def self.select_borough
    puts "Enter any number of boroughs separated by commas (Manhattan, Brooklyn, etc),"
    puts "or (C)ancel or (E)xit"
    input = gets.chomp.downcase
    puts ""
    puts "Here are today's events in #{input.capitalize}:"
    puts ""
    unless input == "e"
      self.search_borough(input).each do |event|
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

  def self.search_time(input)

  end

  def self.select_time
    puts "Enter a (12-hour)time to see a list of events starting from that time,"
    puts "or (c)ancel or (c)xit"
    input = gets.chomp[0].to_i
    puts ""
    puts "Here are today's events starting from #{input}:"
    puts ""
    unless input == "e"
      self.search_time(input).each do |event|
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
