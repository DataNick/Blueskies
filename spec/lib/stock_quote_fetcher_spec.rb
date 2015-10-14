require 'rails_helper'
require './lib/stock_quote_fetcher/stock_quote_fetcher.rb'

RSpec.describe StockQuoteFetcher, type: :model do
  describe "stock_quote_fetcher new method" do
    subject {StockQuoteFetcher.new()}
    it { should be a new(StockQuoteFetcher) }
  end

end


