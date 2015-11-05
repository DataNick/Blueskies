require './lib/stock_quote_fetcher/stock_quote_fetcher.rb'

class Stock < ActiveRecord::Base
	has_many :historical_prices
  has_many :portfolio_stocks
  has_many :portfolios, through: :portfolio_stocks


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


  # miss = []
  # 0.upto(url.length) do |x|
  #   miss << x if url[x] != yahoo_string[x]
  # end
  # puts miss


