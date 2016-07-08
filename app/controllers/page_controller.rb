class PageController < ApplicationController
  def index
    require 'nokogiri'
    require 'open-uri'

    url = "http://minfin.com.ua/"

    data = Nokogiri::HTML(open(url))
    @bid = data.css('.mf-currency-bid')[1]
    @dollarbid = @bid.text.strip[0]+@bid.text.strip[1]+@bid.text.strip[2]+@bid.text.strip[3]+@bid.text.strip[4]  
    @ask = data.css('.mf-currency-ask')[1]
    @dollarask = @ask.text.strip[0]+@ask.text.strip[1]+@ask.text.strip[2]+@ask.text.strip[3]+@ask.text.strip[4]
    
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')
    data_table.new_column('number', 'Bid')
    data_table.new_column('number', 'Ask')

      
      Currency.order("created_at DESC").limit(15).each do |currency|
        data_table.add_row([currency.date, currency.bid, currency.ask])
      end

    
    

    option = { :width => 750, :height => 280, :title => "Exchange rate for the past 15 days", :legend => 'bottom' }
    @chart = GoogleVisualr::Interactive::LineChart.new(data_table, option)
  end

  def min
    Currency.all.order("created_at DESC").limit(15).each do | currency|

    end
  end
end
