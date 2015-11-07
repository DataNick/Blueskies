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

