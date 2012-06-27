# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'hombuscrape'

timetable = HombuScrape::Timetable.new

timetable.shitpile.each do |entry|
  shihan = Shihan.find_or_create_by_name_en(entry[:teacher])
  scheduled_class = ScheduledClass.create(day: entry[:day],
                                          time: entry[:time],
                                          shihan_id: shihan.id)
end
