require 'mechanize'

url = 'http://203.211.178.140/cgi-bin/mycgi/eachclass.cgi?Lang=e'
agent = Mechanize.new
agent.default_encoding = 'utf-8'
agent.force_default_encoding = true

requested_date = gets.chomp
page = agent.post(url, 'FormDate' => requested_date)

items = page.search('td:nth-child(2) td')

puts items
