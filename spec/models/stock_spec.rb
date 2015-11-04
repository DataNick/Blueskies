require 'rails_helper'

RSpec.describe Stock, type: :model do
	describe "stock assocations" do
		it { should have_many(:historical_prices) }
	end 

	describe "correctly updates stock values" do
		stock = Stock.create(ticker: "GOOG")
		stock.today_price
	end

	# describe "stock_quote_fetcher new method" do
 #    subject {Stock.test}
 #    it { should be_a_new(StockQuoteFetcher) }
 #  end


end
