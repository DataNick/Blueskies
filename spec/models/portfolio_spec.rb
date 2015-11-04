require 'rails_helper'

RSpec.describe Portfolio, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:user) }

  before (:each) do
    @portfolio = create(:portfolio)
  end


  it "it should have a portfolio object" do
    expect(@portfolio).to be_valid
  end

end
