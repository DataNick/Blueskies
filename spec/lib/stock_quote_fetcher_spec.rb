require 'rails_helper'
require './lib/stock_quote_fetcher/stock_quote_fetcher.rb'

RSpec.describe StockQuoteFetcher, type: :model do
  describe "stock_quote_fetcher new method" do
    subject {StockQuoteFetcher.new()}
    it { should be a new(StockQuoteFetcher) }
  end

  describe "stock_quote_fetcher single argument" do
    subject { StockQuoteFetcher.new(Stock.new(ticker: "GOOG")).stock_fetch}
    it {should be new(Hash("GOOG" =>{name: String.new, price: bigdecimal.new, date: Time.new} ))}
  end

end


