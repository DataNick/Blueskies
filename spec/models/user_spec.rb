require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should have_many(:portfolios) }

  describe "ensure user is authenticated" do
    it "should be true" do
      @user = User.new
      expect(@user).to be_truthy
    end

    it "should not be valid without an email" do
      @user = User.new
      @user.email = nil
      expect(@user).not_to be_valid
    end

    # it "should have a portfolio" do
    #   @user = User.new
    #   @user.id = 1
    #   @portfolio = Portfolio.new
    #   @portfolio.user_id = @user.id
    #   # @user.portfolios = nil
    #   expect(@user.@portfolio).to be_truthy

    # end
  end

end
