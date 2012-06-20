require './hombuscrape'

daily = HombuScrape::Dailyclass.new
daily.get_classes('2012/06/20')
