require './lib/stock_quote_fetcher/stock_quote_fetcher.rb'

class Stock < ActiveRecord::Base
	has_many :historical_prices
  has_many :portfolios


  def self.test
    puts StockQuoteFetcher.new
  end

  def self.update_current_stock(*stocks)
    fetcher = StockQuoteFetcher.new(stocks)
    puts fetcher.inspect
    prices = fetcher.update_prices
    fetcher.formatted_stock
  end

  def today_price
  end

end
