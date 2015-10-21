require 'rails_helper'
require './lib/stock_quote_fetcher/stock_quote_fetcher.rb'

RSpec.describe StockQuoteFetcher do
  # describe "stock_quote_fetcher new method" do
  #   subject {StockQuoteFetcher.new()}
  #   it { should be_a_new(StockQuoteFetcher) }
  # end

  # describe "stock_quote_fetcher single argument" do
  #   stock=Stock.new(ticker: "GOOG")
  #   sqf=StockQuoteFetcher.new(stock)
  #   subject {sqf.stock_fetch}
  #   it {should be (Hash("GOOG" =>{name: "GOOG", price: 99, date: Time.now} ))}
  # end
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
          last_price: BigDecimal.new("642.61"), 
          last_trade: DateTime.new(2015, 10, 21, 4, 0, 0), 
          stock_exchange: "NMS" }])
        end
      end
    end
end


