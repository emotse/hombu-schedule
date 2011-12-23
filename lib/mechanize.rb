require 'mechanize'
require 'nokogiri'

url = 'http://203.211.178.140/cgi-bin/mycgi/eachclass.cgi?Lang=e'
agent = Mechanize.new
agent.default_encoding = 'utf-8'
agent.force_default_encoding = true

page = agent.get(url)
form = page.forms.first
button = form.button_with(:value => '2011/12/25')
form.values << button.value

agent.submit form

items = page.search('td:nth-child(2) td')
