class Stock < ActiveRecord::Base
	has_many :historical_prices

  def self.update_current_price(tickers)
    
  end

end
