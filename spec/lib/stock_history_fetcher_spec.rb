require 'rails_helper'
require './lib/stock_quote_fetcher/stock_history_fetcher.rb'

RSpec.describe StockHistoryFetcher, type: :model do
  describe "should return historical objects" do
  	it "returns correct structure" do
  		VCR.use_cassette("yahoo_historical_price") do
        t = Time.new(2015, 10, 30, 0, 0, 0)
        stock = Stock.new(ticker: "YHOO")
        options = {
          start_date: (t - 3.months).strftime("%Y-%m-%d"),
          end_date: t.strftime("%Y-%m-%d")
        }
        message = StockHistoryFetcher.new(
          [stock.ticker], options).fetch
		    expect(message.class).to eq(Hash)
		    expect(message[stock.ticker].first).to eq(
		    {
		    	date:  DateTime.new(2015,10,30),
		    	day_price_close: BigDecimal.new("35.700001")
		    	})
		    expect(message[stock.ticker].count).to eq(66)
  		end
  	end
  end
end