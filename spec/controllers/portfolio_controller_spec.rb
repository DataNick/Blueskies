require 'rails_helper'

RSpec.describe PortfolioController, type: :controller do
	before (:each) do
    @portfolio = create(:portfolio)
  end

	describe 'GET #show' do

		it "gets the show page" do
			get :show, id: @portfolio.id
			expect(response).to be_success
			expect(response.body).to eq(200)
		end
	end
end
