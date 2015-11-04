require 'rails_helper'
require './lib/stock_quote_fetcher/stock_quote_fetcher.rb'

RSpec.describe StockQuoteFetcher do

    describe "stock_quote_fetcher correctly returns correct information" do
      it "should be true" do
        VCR.use_cassette("cassettes") do

          stock = Stock.new(ticker: "GOOG")
          sqf = StockQuoteFetcher.new(stock)

          expect(sqf.stock_fetch).to be_truthy
        end
      end


      it "returns required attributes" do
        VCR.use_cassette("returned_api_data") do
          stock = Stock.new(ticker: "GOOG")
          sqf = StockQuoteFetcher.new(stock)
          expect(sqf.stock_fetch).to eq([{ ticker: "GOOG",
          name: "Alphabet Inc.",
          last_price: BigDecimal.new("708.49"),
          last_trade: DateTime.new(2015, 10, 27, 15, 59, 0),
          stock_exchange: "NMS" }])
        end
      end

      it "returns multiple stock objects" do
        VCR.use_cassette("returns_multiple_data") do
          apple = Stock.new(ticker: "AAPL")
          google = Stock.new(ticker: "GOOG")
          tesla = Stock.new(ticker: "TSLA")
          sqf = StockQuoteFetcher.new(apple, google, tesla)
          expect(sqf.stock_fetch).to eq([{
          ticker: "AAPL",
          name: "Apple Inc.",
          last_price: BigDecimal.new("114.55"),
          last_trade: DateTime.new(2015, 10, 27, 16, 0, 0),
          stock_exchange: "NMS"
          },
          {
          ticker: "GOOG",
          name: "Alphabet Inc.",
          last_price: BigDecimal.new("708.49"),
          last_trade: DateTime.new(2015, 10, 27, 15, 59, 0),
          stock_exchange: "NMS"
          },
          {
          ticker: "TSLA",
          name: "Tesla Motors, Inc.",
          last_price: BigDecimal.new("210.35"),
          last_trade: DateTime.new(2015, 10, 27, 16, 0, 0),
          stock_exchange: "NMS"
          }])

        end
      end
    end
end


