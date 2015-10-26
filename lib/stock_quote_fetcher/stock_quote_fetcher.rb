class StockQuoteFetcher
  attr_reader :stocks

  def initialize(*stocks)
    @stocks = stocks
  end

  def stock_fetch
    yahoo_tickers = @stocks.map {|x| "'" + x.ticker + "'"}.join(', ')
    puts "LOOKHERE: #{yahoo_tickers.class}"
    puts "#{yahoo_tickers}"
    if yahoo_tickers.length > 0
      puts "fetching data from yahoo api..."
      url = 'https://query.yahooapis.com/v1/public/yql?q='
      url += URI.encode("SELECT * FROM yahoo.finance.quotes WHERE symbol IN (#{yahoo_tickers})")
      url += '&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
      data = open(url, {:read_timeout=>3}).read
      stock_hash = JSON.parse(data)
      formatted_stock(stock_hash)
    end
  end


  def formatted_stock(stock_hash)
    puts "checking..."
    # #calling child.last and getting last stock item from collection
    # puts stock_hash.class
    # puts stock_hash["query"]["results"]["quote"]
 
    stock_collection = []
    puts stock_hash["query"]["results"]["quote"].class == Hash
    if stock_hash["query"]["results"]["quote"].class == Hash
      stock_item = {
        ticker: stock_hash["query"]["results"]["quote"]["symbol"],
        name: stock_hash["quote"]["results"]["quote"]["Name"],
        last_price: BigDecimal.new(stock_hash["query"]["results"]["quote"]["LastTradePriceOnly"]).to_f,
        last_trade: formatted_date_time(stock_hash["quote"]["results"]["quote"]["LastTradeDate"],
        stock_hash["quote"]["results"]["quote"]["LastTradeWithTime"]),
        stock_exchange: stock_hash["quote"]["results"]["quote"]["StockExchange"]
      }
      puts "checking again..."
      puts stock_item
      stock_collection << stock_item
      puts stock_collection
    else
      stock_hash["query"]["results"]["quote"].each do |child|
    	 stock_item = {ticker: child["symbol"],
        name: child["Name"], 
        last_price: BigDecimal.new(child["LastTradePriceOnly"]).to_f,
        last_trade: formatted_date_time(child["LastTradeDate"], 
          child["LastTradeWithTime"]),
        stock_exchange: child["StockExchange"]}
        stock_collection << stock_item
    end
    end
    stock_collection
  end

  def formatted_date_time(last_trade_date, trade_with_time)
    puts "#{last_trade_date.class}"

    if !last_trade_date.nil? || !trade_with_time.nil?
      date_array = last_trade_date.split("/")
      time_array = trade_with_time.split(":")
      hour=time_array[0].to_i
      last_numbers=time_array[1].chars[0]+ time_array[1].chars[1]
      minute = last_numbers.to_i
      month = date_array[0].to_i
      day = date_array[1].to_i
      year = date_array[2].to_i
      new_date = DateTime.new(year, month, day, hour, minute)
    else
      date_time = nil
    end
  end

  # def get_formatted_time(time_with_price)
  #   time_array=time_with_price.split(":")
  #   hour=time_array[0]
  #   last_numbers=time_array[1].chars[0] + time_array[1].chars[1]
  # end

end

