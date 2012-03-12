require 'mechanize'

# .td3 , .td2, .td1, .title2, center th
url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
agent = Mechanize.new
page = agent.get(url)
page.search('br').each{ |br| br.replace('') }
shitpile = []

regular = page.search( "center:nth-child(6)" )
beginner = page.search( "center:nth-child(7)" )

def count_rows table
  rows = table.search 'th'
  return rows.length
end

def get_times table, column
  time = table.search ".title2:nth-child(#{column + 2})"
  return time.text
end

def parse_table table
  rows = count_rows( table ) + 1
  (2..rows).each do |row_index|
    row = table.search "tr[align='center']:nth-child(#{row_index}) *"
    day = row.shift.text
    row_info = parse_row table, row, day
    puts row_info
  end
end

def parse_row table, row, day
  row_info = []
  row.each_with_index do |column, column_index|
    time = get_times table, column_index
    teacher = column.text
    next if teacher == ""
    row_info << { :time => time, :teacher => teacher, :day => day }
  end
  return row_info
end

parse_table regular
