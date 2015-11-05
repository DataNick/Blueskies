class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :portfolio_stocks
  has_many :stocks, through: :portfolio_stocks
  # accepts_nested_attributes_for :stocks
end
