desc "This task is called by the Heroku scheduler add-on"
task :add_currency => :environment do
  require 'nokogiri'
  require 'open-uri'

  url = "http://minfin.com.ua/"

  data = Nokogiri::HTML(open(url))
  @bid = data.css('.mf-currency-bid')[1]
  @dollarbid = @bid.text.strip[0]+@bid.text.strip[1]+@bid.text.strip[2]+@bid.text.strip[3]+@bid.text.strip[4]  
  @ask = data.css('.mf-currency-ask')[1]
  @dollarask = @ask.text.strip[0]+@ask.text.strip[1]+@ask.text.strip[2]+@ask.text.strip[3]+@ask.text.strip[4]
  Currency.create(date: Time.now, bid: @dollarbid.gsub(/[,]/, '.'), ask: @dollarask.gsub(/[,]/, '.'))
end