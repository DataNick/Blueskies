require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
	before(:each) do
	    @portfolio = create(:portfolio)
	end

	describe 'GET #show' do
		it "gets the show page" do
			get :show, id: @portfolio.id
			expect(response).to be_success
		end
	end

	describe 'POST #update' do
		it 'gets the new page' do
			get :new
			expect(response).to be_success
		end
	end

	describe 'POST #create' do
	end

	describe 'POST #create' do
	end
end
