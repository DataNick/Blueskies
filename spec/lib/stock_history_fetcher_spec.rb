require 'rails_helper'
require './lib/stock_quote_fetcher/stock_history_fetcher.rb'

RSpec.describe StockHistoryFetcher, type: :model do
  describe "should return historical objects" do
  	it "returns correct structure" do
  		VCR.use_cassette("yahoo_historical") do
		  	stock = Stock.new(ticker: "GOOG")
		    message = StockHistoryFetcher.new([stock.ticker]).fetch
		    
		    expect(message.class).to eq(Hash)
		    expect(message[stock.ticker].first).to eq(
		    {
		    	date:  DateTime.new(2015,10,28),
		    	day_price_close: BigDecimal.new("712.97998")
		    	})
		    expect(message[stock.ticker].count).to eq(65)
  		end
  	end
  end
end