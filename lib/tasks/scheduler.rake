desc "This task is called by the Heroku scheduler add-on"
task :add_currency => :environment do
  puts "Updating feed..."
  Currency.create(date: Time.now, bid: @dollarbid.gsub(/[,]/, '.'), ask: @dollarask.gsub(/[,]/, '.'))
  puts "done."
end