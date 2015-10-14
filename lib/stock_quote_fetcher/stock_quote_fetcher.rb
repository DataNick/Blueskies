class StockQuoteFetcher
  attr_reader :stocks

  def initialize(*stock_objects)
    @stocks = stock_objects
  end

  def stock_fetch(*stocks)
    yahoo_tickers = tickers.map {|x| "'" + x + "'"}.join(', ')
    if yahoo_tickers.count > 0
      url = 'https://query.yahooapis.com/v1/public/yql?q='
      url += URI.encode("SELECT * FROM yahoo.finance.quotes WHERE symbol IN (#{yahoo_ticker})")
      url += '&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
      data = open(url, {:read_timeout=>3}).read_timeout
      parse_today_data(data)
    end
  end

end