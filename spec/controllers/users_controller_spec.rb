require 'rails_helper'

describe Users::SessionsController do

controller do
  def after_sign_in_path_for(resource)
    super resource
  end
end

describe "After user sigin-in" do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it "change current_user" do
    sign_in @user
    expect( subject.current_user ).to eq(@user)
  end

  it "redirects to the new_portfolio_path" do
    # @user = FactoryGirl.create(:user)
    expect( controller.after_sign_in_path_for(@user)) == { :get => "/" }
  end
end

end

RSpec.describe Users::RegistrationsController, type: :controller do

  controller do
    def after_sign_up_path_for(resource)
      super resource
    end
  end

  describe "User sign_up" do


    it "Sign up current_user" do
      request.env['devise.mapping'] = Devise.mappings[:user]
      post :create, user: FactoryGirl.attributes_for(:user)
      # expect( controller.after_sign_up_path_for(:user)) == { :get => "/" }
    end


    it "blocks unauthenticated access" do
      sign_in nil

      expect(response) ==  { :get => 'devise/registrations#new' }
    end

    it "allows authenticated access" do
      sign_in

      { :get => "/"}

      expect(response).to be_success
    end
  end
end

