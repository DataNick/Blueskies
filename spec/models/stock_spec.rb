require 'rails_helper'

RSpec.describe Stock, type: :model do
	describe "stock assocations" do
		it { should have_many(:historical_prices) }
	end 

	describe "correctly updates stock values" do
		stock = Stock.create(ticker: "GOOG")
		stock.today_price
		
		expect(stock.reload.last_price).to eq(15.99)
		expect(stock.reload.last_trade).to eq(Time.now)
		expect(stock.reload.stock_exchange).to eq("Some exchange")
		expect(stock.reload.name).to eq("Not google!")
	end
end
