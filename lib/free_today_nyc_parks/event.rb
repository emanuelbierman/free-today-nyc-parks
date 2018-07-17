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

  def self.print_all
    puts "Here are the events for #{self.today}:"
    puts ""
    self.all.each_with_index do |event, index|
      puts "#{index + 1}"
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts "When:    #{event.start_time} - #{event.end_time}"
      puts ""
      puts "--------------------------"
      puts ""
    end
    FreeTodayNycParks::CLI.new.menu
  end

  def detail
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

  def self.print_detail(input, array = self.all)
    if input.between?(1, array.size)
      array.each_with_index do |event, index|
        if input == (index + 1)
          event.detail
        end
      end
    else
      puts ""
      puts "Please enter a number from 1 to #{array.size}."
      puts ""
    end
    FreeTodayNycParks::CLI.new.menu(array)
  end

  def self.select_borough(input)
    input = input.split(", ")

    self.all.select do |event|
      event.borough == input[0] || event.borough == input[1]
    end
  end

  def self.filter_borough
    puts "Enter any number of boroughs separated by commas (Manhattan, Brooklyn, etc):"
    puts "or return to the full (L)ist:"
    input = gets.chomp.downcase
    unless input == "l"
      if self.select_borough(input) == []
        puts ""
        puts "There are no remaining events in #{input.capitalize} for today."
        puts ""
      else
        puts ""
        puts "Here are today's events in #{input.capitalize}:"
        puts ""
        selected_boroughs = self.select_borough(input)
        selected_boroughs.each_with_index do |event, index|
          puts "#{index + 1}"
          puts "What:    #{event.title}"
          puts "Where:   #{event.location}"
          puts "When:    #{event.start_time} - #{event.end_time}"
          puts ""
          puts "--------------------------"
          puts ""
        end
        FreeTodayNycParks::CLI.new.menu(selected_boroughs)
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
    self.free.each_with_index do |event, index|
      puts "#{index + 1}"
      puts "What:    #{event.title}"
      puts "Where:   #{event.location}"
      puts "When:    #{event.start_time} - #{event.end_time}"
      puts ""
      puts "--------------------------"
      puts ""
    end
    FreeTodayNycParks::CLI.new.menu(self.free)
  end

  # def self.select_time(input)
  #   binding.pry
  #   if input.include?(":")
  #     hour = input.split(/:/)[0].to_i
  #     self.all.select do |event|
  #       event.start_time.split(":")[0] >= hour
  #     end
  #   else
  #     self.all.select do |event|
  #       event.start_time.split(":")[0] >= input
  #     end
  #   end
  #   # if input.include?(/[ap]\.m\./)
  #   #   meridiem = input.grep(/[ap](?=\.m\.)/)
  #   #   if meridiem == "a"
  # end

  # def self.filter_time
  #   puts "Enter a (1-12) time to see a list of events starting from that hour:"
  #   puts "or see the full (L)ist again, or (E)xit:"
  #   input = gets.chomp.downcase
  #   unless input == "e"
  #     if input == "l"
  #       self.print_list
  #     elsif self.select_time(input) == []
  #       puts ""
  #       puts "There are no events happening today at or after #{input}."
  #       puts ""
  #     else
  #       puts ""
  #       puts "Here are today's events starting from #{input}:"
  #       puts ""
  #       selected_times = self.select_time(input)
  #       selected_times.each_with_index do |event, index|
  #         puts "#{index + 1}"
  #         puts "What:    #{event.title}"
  #         puts "Where:   #{event.location}"
  #         puts "When:    #{event.start_time} - #{event.end_time}"
  #         puts ""
  #         puts "--------------------------"
  #         puts ""
  #       end
  #       FreeTodayNycParks::CLI.new.menu(selected_times)
  #     end
  #   end
  # end

end
