class StockQuoteFetcher
  attr_reader :stocks

  def initialize(*stocks)
    @stocks = stocks
  end

  def stock_fetch
    yahoo_tickers = @stocks.map {|x| "'" + x.ticker + "'"}.join(', ')
    puts "LOOKHERE: #{yahoo_tickers.class}"
    if yahoo_tickers.length > 0
      url = 'https://query.yahooapis.com/v1/public/yql?q='
      url += URI.encode("SELECT * FROM yahoo.finance.quotes WHERE symbol IN (#{yahoo_tickers})")
      url += '&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
      data = open(url, {:read_timeout=>3}).read
      stock_hash = JSON.parse(data)
      formatted_stock(stock_hash)
    end
  end


  def formatted_stock(stock_hash)
    first_hash = []
    stock_hash["query"]["results"].each do |child|
  	 second_hash = {ticker: child.last["symbol"],
      name: child.last["Name"], 
      last_price: BigDecimal.new(child.last["LastTradePriceOnly"]),
      last_trade: formatted_date_time(child.last["LastTradeDate"], 
        child.last["LastTradeWithTime"]),
      stock_exchange: child.last["StockExchange"]}

      first_hash << second_hash
  	end
    first_hash
  end

  def formatted_date_time(last_trade_date, trade_with_time)
    date_array = last_trade_date.split("/")
    time_array = trade_with_time.split(":")
    hour=time_array[0].to_i
    last_numbers=time_array[1].chars[0]+ time_array[1].chars[1]
    minute = last_numbers.to_i
    month = date_array[0].to_i
    day = date_array[1].to_i
    year = date_array[2].to_i
    new_date = DateTime.new(year, month, day, hour, minute)
  end

  # def get_formatted_time(time_with_price)
  #   time_array=time_with_price.split(":")
  #   hour=time_array[0]
  #   last_numbers=time_array[1].chars[0] + time_array[1].chars[1]
  # end

end

