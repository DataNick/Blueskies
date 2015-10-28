class StockQuoteFetcher
  attr_reader :stocks

  def initialize(*stocks)
    @stocks = stocks
  end

  def stock_fetch
    yahoo_tickers = @stocks.map {|x| "'" + x.ticker + "'"}.join(', ')
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
    stock_collection = []
      if stock_hash["query"]["results"]["quote"].class == Hash
        stock_hash = stock_hash["query"]["results"]["quote"]
        hash = combine_price_hashes(stock_hash)
        stock_collection << hash unless hash.nil?
      else
        stock_hash["query"]["results"]["quote"].each do |stock_hash|
          hash = combine_price_hashes(stock_hash)
          stock_collection << hash unless hash.nil?
        end
      end
      return stock_collection
  end

  def combine_price_hashes(stock_hash)
    if stock_hash["Name"].nil?
        nil
    else
        {
          ticker: stock_hash["symbol"],
          name: stock_hash["Name"],
          last_price: BigDecimal.new(stock_hash["LastTradePriceOnly"]).to_f,
          last_trade: parse_last_trade_time(stock_hash),
          stock_exchange: stock_hash["StockExchange"]
        }
    end
  end  

  def parse_last_trade_time(stock_hash)
    mdy = parse_month_day_year(stock_hash)
    hrs_mins = parse_hrs_mins(stock_hash)
    DateTime.new(mdy[2],mdy[0],mdy[1],hrs_mins[0],hrs_mins[1])
  end 

  def parse_month_day_year(stock_hash)
    stock_hash["LastTradeDate"].split('/').map {|x| x.to_i}
  end

  def parse_hrs_mins(stock_hash)
    clock12hr = stock_hash["LastTradeWithTime"].split.first
    am_or_pm = clock12hr[clock12hr.length-2..clock12hr.length-1]
    hrs_mins = clock12hr[0..clock12hr.length-3].split(':').map {|x| x.to_i}
    hrs_mins[0] += 12 if am_or_pm == "pm" && hrs_mins[0] < 12
    return hrs_mins
  end
end

