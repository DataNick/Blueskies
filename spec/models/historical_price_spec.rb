require 'rails_helper'

RSpec.describe HistoricalPrice, type: :model do
	describe "historical_prices assocations" do
		it { should belong_to(:stock) }
	end
end
