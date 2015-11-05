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

	describe 'GET #new' do
		it 'should redirect to login when user not logged in' do
			get :new
			expect(response).to redirect_to(new_user_session_path)
		end

		describe "logged in user" do
			login_user
			it 'should get new page' do
				get :new
				expect(response).to be_success
			end
		end
	end

	describe 'POST #create' do
		describe "logged in user" do
			login_user
			it 'should create a new portfolio when user logged in' do
				expect{
				    post :create, portfolio: FactoryGirl.attributes_for(:portfolio)
				  }.to change(Portfolio,:count).by(1)
				# expect(response).to redirect_to(portfolio_path(:portfolio)) 
				# expect(response).to render_template(:show)
			end
		end
	end
end
