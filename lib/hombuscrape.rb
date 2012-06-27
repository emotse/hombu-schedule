require 'mechanize'
require 'date'

module HombuScrape
  class Timetable
    attr_reader :shitpile

    def initialize
      @shitpile = []
      agent = Mechanize.new
      timetable_url = 'http://www.aikikai.or.jp/eng/hombu/timetable.htm'
      page = load_timetable_page(agent, timetable_url)
      class_tables = get_class_tables(page)
      class_tables.each { |class_table| parse_table(class_table) }
    end

    def load_timetable_page(agent, url)
      page = agent.get(url)
      normalized_page = normalize_page(page)

      return normalized_page
    end

    def normalize_page(page)
      page.search('br').each { |br| br.replace('') }

      return page
    end

    def get_class_tables(page)
      regular = page.search("center:nth-child(6)")
      beginner = page.search("center:nth-child(9)")

      return [regular, beginner]
    end

    def parse_table(table)
      rows = count_rows(table)
      (2..rows).each do |row_index|
        row = table.search("tr[align='center']:nth-child(#{row_index}) *")
        day = row.shift.text
        row_info = parse_row(table, row, day)
      end
    end

    def parse_row(table, row, day)
      row_info = []
      row.each_with_index do |column, column_index|
        time = get_times(table, column_index)
        teacher = column.text
        next if teacher == ''
        teacher = teacher.gsub(/^.*[a-z]([A-Z].*)$/, '\1')
        @shitpile << { time: time,
                       teacher: teacher,
                       day: day }
      end
    end

    def get_times(table, column)
      time = table.search(".title2:nth-child(#{column + 2})")

      return time.text
    end

    def count_rows(table)
      rows = table.search('th')

      return rows.length + 1
    end
  end

  class Dailyclass
    attr_reader :shitpile

    def initialize(date)
      @date = date
      @shitpile = []
      url = 'http://203.211.178.140/cgi-bin/mycgi/eachclass.cgi?Lang=e'
      agent = Mechanize.new
      agent.default_encoding = 'utf-8'
      agent.force_default_encoding = true

      get_classes(agent, url)
    end

    # dates need to be in 'yyyy/mm/dd' format
    def get_classes(agent, url)
      page = agent.post(url, 'FormDate' => @date)
      day = get_day
      items = page.search('td:nth-child(2) td')
      items.each do |item|
        curr_class = parse_class(item)
        curr_class.merge!(day: day)
        @shitpile << curr_class
      end
    end

    def get_day
      day = Date.parse(@date)

      return day.strftime('%a')
    end

    def parse_class(row)
      row_text = row.text
      time = row_text.match(/^\d+:\d+-\d+:\d+/).to_s
      teacher = row_text.match(/\w*\.?\w+$/).to_s

      return { time: time, teacher: teacher }
    end
  end
end


