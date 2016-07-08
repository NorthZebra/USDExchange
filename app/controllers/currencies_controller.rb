class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :edit, :update, :destroy]

  def index
    
    @currencies = Currency.all.order("created_at DESC")

  end

  def new
    require 'nokogiri'
    require 'open-uri'

    url = "http://minfin.com.ua/"

    data = Nokogiri::HTML(open(url))
    @bid = data.css('.mf-currency-bid')[1]
    @dollarbid = @bid.text.strip[0]+@bid.text.strip[1]+@bid.text.strip[2]+@bid.text.strip[3]+@bid.text.strip[4]  
    @ask = data.css('.mf-currency-ask')[1]
    @dollarask = @ask.text.strip[0]+@ask.text.strip[1]+@ask.text.strip[2]+@ask.text.strip[3]+@ask.text.strip[4]
    
    @currency = Currency.create(date: Time.now, bid: @dollarbid.gsub(/[,]/, '.'), ask: @dollarask.gsub(/[,]/, '.'))
  end
  
  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to @currency, notice: 'Currency was successfully updated.' }
        format.json { render :show, status: :ok, location: @currency }
      else
        format.html { render :edit }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @currency.destroy
    respond_to do |format|
      format.html { redirect_to currencies_url, notice: 'Currency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Currency.import(params[:file])
    redirect_to currencies_path, notice: "Currencies uploaded successfully"
  end

  
  private
    def set_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:date, :bid, :ask)
    end

end

