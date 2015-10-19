require 'rails_helper'
require './lib/stock_quote_fetcher/stock_history_fetcher.rb'

RSpec.describe StockHistoryFetcher, type: :model do
  describe "should return historical objects" do
  	it "returns correct structure" do
	  	stock = Stock.new(ticker: "GOOG")
	    message = StockHistoryFetcher.new([stock.ticker]).fetch
	    
	    expect(message.class).to eq("Array")
	    expect(message.first).to eq(
	    {
	    	date:  DateTime.new(2015,10,19),
	    	day_price_close: BigDecimal.new("99")
	    	})
	    expect(message.count).to eq(65)
  	end
  end
end