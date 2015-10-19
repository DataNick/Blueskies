@stocks = [Stock.new(ticker: "GOOG")]
yahoo_tickers = @stocks.map {|stock| "'" + stock.ticker + "'"}.join(', ')

url = 'https://query.yahooapis.com/v1/public/yql?q='
url += URI.encode("SELECT * FROM yahoo.finance.quotes WHERE symbol IN (#{yahoo_tickers})")
url += '&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
data = open(url, {:read_timeout=>3}).read
hash = JSON.parse(data)


"https://query.yahooapis.com/v1/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22GOOG%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="


"https://query.yahooapis.com/v1/

public/yql?q=SELECT%20*%20FROM%20yahoo.finance.quotes%20WHERE%20symbol%20IN%20(GOOG)

&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="


"https://query.yahooapis.com/v1/

public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22FB%22)

&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="

ticker = hash["query"]["results"]["quote"]["symbol"]

name = hash["query"]["results"]["quote"]["Name"]

datetime_of_last_trade = hash["query"]["results"]["quote"]["LastTradeDate"],
hash["query"]["results"]["quote"]["LastTradeWithTime"]

last_price = hash["query"]["results"]["quote"]["LastTradePriceOnly"]

stock_exchange = hash["query"]["results"]["quote"]["StockExchange"]