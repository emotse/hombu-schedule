# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

parse_table regular, shitpile
parse_table beginner, shitpile

shitpile.each do |entry|
  shihan = Shihan.create :name_en => entry[:teacher]
  shihan = Shihan.find_by_name_en entry[:teacher] unless shihan.id?
  scheduled_class = ScheduledClass.create :day => entry[:day], :time => entry[:time], :shihan_id => shihan.id
end
