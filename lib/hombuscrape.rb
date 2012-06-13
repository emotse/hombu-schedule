require 'mechanize'

module HombuScrape
  class Timetable
    attr_reader :shitpile

    def initialize
      @shitpile = Array.new
      agent = Mechanize.new
      timetable_url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
      page = load_timetable_page(agent, timetable_url)
    end

    def load_timetable_page(agent, url)
      page = agent.get(url)
      normalized_page = normalize_page(page)

      return normalized_page
    end

    def normalize_page(page)
      page.search('br').each do |br|
        br.replace('')
      end

      return page
    end
  end
end

# .td3 , .td2, .td1, .title2, center th
url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
agent = Mechanize.new
page = agent.get(url)
page.search('br').each{ |br| br.replace('') }
shitpile = []

regular = page.search "center:nth-child(6)"
beginner = page.search "center:nth-child(9)"

def count_rows table
  rows = table.search 'th'
  return rows.length
end

def get_times table, column
  time = table.search ".title2:nth-child(#{column + 2})"
  return time.text
end

def parse_table table, shitpile
  rows = count_rows( table ) + 1
  (2..rows).each do |row_index|
    row = table.search "tr[align='center']:nth-child(#{row_index}) *"
    day = row.shift.text
    row_info = parse_row table, row, day, shitpile
  end
end

def parse_row table, row, day, shitpile
  row_info = []
  row.each_with_index do |column, column_index|
    time = get_times table, column_index
    teacher = column.text
    next if teacher == ""
    teacher = teacher.gsub /^.*[a-z]([A-Z].*)$/, '\1'
    shitpile << { :time => time, :teacher => teacher, :day => day }
  end
end

#parse_table regular, shitpile
#parse_table beginner, shitpile

#shitpile.each do |entry|
#  shihan = Shihan.create :name_en => entry[:teacher]
#  shihan = Shihan.find_by_name_en entry[:teacher] unless shihan.id?
#  scheduled_class = ScheduledClass.create :day => entry[:day], :time => entry[:time], :shihan_id => shihan.id
#end
