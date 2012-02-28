require 'mechanize'

class Timetable
  attr_reader :shitpile

  def initialize
    url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
    agent = Mechanize.new
    @page = agent.get(url)
    @shitpile = {
      :Mon => [],
      :Tue => [],
      :Wed => [],
      :Thu => [],
      :Fri => [],
      :Sat => [],
      :Sun => []
    }
    #self.fill_shitpile
  end

  def get_times(selector)
    times = @page.search(selector)
    times.shift
    return times
  end

  def get_classes(selector)
    curr_class = @page.search(selector)
    return curr_class
  end

  def get_todays_class(times, classes, type)
    class_list = []
    times.each_with_index do |time, index|
      class_time = time.content
      class_teacher = classes[index].content
      next if class_teacher == ''
      class_list << {
        :time => class_time,
        :teacher => class_teacher,
        :type => type
      }
    end
    return class_list
  end

  def fill_shitpile
    regular_time_selector = 'center:nth-child(6) .title2'
    beginner_time_selector = 'center:nth-child(9) .title2'

    @shitpile.keys.each_with_index do |key, index|
      regular_class_selector = "center:nth-child(6) tr:nth-child(#{index + 3}) td"
      beginner_class_selector = "center:nth-child(9) tr:nth-child(#{index + 3}) td"
      regular_times = self.get_times(regular_time_selector)
      beginner_times = self.get_times(beginner_time_selector)
      regular_classes = self.get_classes(regular_class_selector)
      beginner_classes = self.get_classes(beginner_class_selector)
      
      @shitpile[key] <<  self.get_todays_class(regular_times, regular_classes, "Regular")
      @shitpile[key] <<  self.get_todays_class(beginner_times, beginner_classes, "Beginner")
    end
  end
end

# .td3 , .td2, .td1, .title2, center th
url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
agent = Mechanize.new
page = agent.get(url)
shitpile = []

regular = 6
beginner = 7
curr_row = 2

def make_selector( table, row )
  return "center:nth-child(#{table}) tr:nth-child(#{row}) *"
end

first_row = page.search make_selector( regular, curr_row )

first_row.each_with_index do |row, row_index|
  day = ""
  if row.text == ""
    day = page.search( make_selector( regular, curr_row + row_index + 1 ).shift.text
    puts day
  end
end




#puts shitpile


#test
#timetable = Timetable.new
#shitpile = timetable.shitpile
#shitpile.keys.each do |key|
  #puts key
  #puts shitpile[key]
#end
