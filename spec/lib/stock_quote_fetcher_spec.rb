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
    describe "stock_quote_fetcher single argument" do
    stock=Stock.new(ticker: "GOOG")
    sqf=StockQuoteFetcher.new(stock)
    subject {sqf.stock_fetch}
    it {should be [{ticker: "GOOG",
      name: "Google Inc.", 
      last_price: BigDecimal.new("663.50"), 
      last_trade: DateTime.now, 
      stock_exchange: String.new}] }
  end
end


