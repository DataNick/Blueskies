class PortfolioStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
end
