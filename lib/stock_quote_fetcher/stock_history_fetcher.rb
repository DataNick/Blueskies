class StockHistoryFetcher
  attr_reader :tickers
  attr_reader :date_start
  attr_reader :date_end

  def initialize(ticker_array, options)
  	@tickers = ticker_array
  	@date_end = options[:end_date] || Time.now.strftime("%Y-%m-%d")
  	@date_start = options[:start_date] || 3.months.ago.strftime("%Y-%m-%d")
  end

  def fetch
  	request_from_yahoo
  end

  private

		def request_from_yahoo
			history_hash = Hash.new(0)
			@tickers.each do |ticker|
				add_stock_to_hash(ticker, history_hash)
			end
			return history_hash
		end

		def add_stock_to_hash(ticker, history_hash)
				url = yahoo_history_url(ticker)
        message = open(url, {:read_timeout=>3}).read
        history_hash.merge!(parse_stock_timeseries(message))
    end

    def yahoo_history_url(ticker)
      url = 'https://query.yahooapis.com/v1/public/yql?q='
      url += URI.encode(%Q(select * from yahoo.finance.historicaldata where symbol = "#{ticker}" and startDate = "#{@date_start}" and endDate = "#{@date_end}")).gsub('=', "%3D")
      url += '&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
    end

		def parse_stock_timeseries(message)
			json = JSON.parse(message)

			data = json["query"]["results"]["quote"] unless json["query"]["http-status-code"] == "404"
			stock_hash = hash_stock_timeseries(data)
			{ data.first["Symbol"] => stock_hash}
		end

		def hash_stock_timeseries(data)
			stock_array = []
			data.each do |days_info|
				date = parse_year_month_day(days_info)
				stock_array << {
					date: date,
					day_price_close: BigDecimal.new("#{days_info["High"]}"),
				}
			end
			return stock_array
		end

		def parse_year_month_day(days_info)
			date_ymd = days_info["Date"].split('-').map {|x| x.to_i}
			DateTime.new(date_ymd[0],date_ymd[1],date_ymd[2])
		end

end