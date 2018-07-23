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

  def self.select_borough(input)
    self.all.select do |event|
      event.borough == input
    end
  end


  def self.free
    self.all.select do |event|
      event.cost == "Free!"
    end
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
