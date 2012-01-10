require 'mechanize'


url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
agent = Mechanize.new
page = agent.get(url)

regular_time_selector = 'center:nth-child(6) .title2'
beginner_time_selector = 'center:nth-child(9) .title2'
regular_day_selector = 'center:nth-child(6) tr:nth-child(3) th'
#regular_class_selector = 'center:nth-child(6) tr:nth-child(4) td'
#beginner_class_selector = 'center:nth-child(9) tr:nth-child(4) td'

regular_times = page.search(regular_time_selector)
regular_times.shift
beginner_times = page.search(beginner_time_selector)
beginner_times.shift
#regular_classes = page.search(regular_class_selector)
#beginner_classes = page.search(beginner_class_selector)

def get_classes(times, classes, type)
  list = []
  times.each_with_index do |time, index|
    class_time = time.content
    class_teacher = classes[index].content
    class_type = type
    next if class_teacher == ''
    list << [class_time, class_teacher, type]
  end
  return list
end

shitpile = {
  :Mon => [],
  :Tue => [],
  :Wed => [],
  :Thu => [],
  :Fri => [],
  :Sat => [],
  :Sun => []
}

shitpile.keys.each_with_index do |key, index|
  regular_class_selector = "center:nth-child(6) tr:nth-child(#{index + 3}) td"
  regular_classes = page.search(regular_class_selector)
  beginner_class_selector = "center:nth-child(9) tr:nth-child(#{index + 3}) td"
  beginner_classes = page.search(beginner_class_selector)
  shitpile[key] <<  get_classes(regular_times, regular_classes, "Regular")
  shitpile[key] <<  get_classes(beginner_times, beginner_classes, "Beginner")
end

#puts shitpile


class Timetable
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
    self.fill_shitpile
  end

  def get_times(selector)
    times = page.search(selector)
    times.shift
    return times
  end

  def get_classes(selector)
    curr_class = page.search(selector)
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
      
      @shitpile[key] <<  self.get_classes(regular_times, regular_classes, "Regular")
      @shitpile[key] <<  self.get_classes(beginner_times, beginner_classes, "Beginner")
    end
  end
end
