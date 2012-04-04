require 'mechanize'

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

<<<<<<< HEAD
first_row.each_with_index do |row, row_index|
  curr_selector = make_selector( regular, time_row + 1 )
  curr_row = page.search curr_selector
  curr_elm = first_row[row_index]
  #puts row.css_path
  if row_index == 0
    day = curr_row[row_index].text
    #puts day
  else
    time = curr_elm.text
    teacher = curr_row[row_index].text
    #puts time, teacher
=======
def parse_table table, shitpile
  rows = count_rows( table ) + 1
  (2..rows).each do |row_index|
    row = table.search "tr[align='center']:nth-child(#{row_index}) *"
    day = row.shift.text
    row_info = parse_row table, row, day, shitpile
>>>>>>> cc7fceec09ba76a56e8e65d561ae4d6981668b7c
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

parse_table regular, shitpile
parse_table beginner, shitpile
