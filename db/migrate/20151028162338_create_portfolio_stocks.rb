class CreatePortfolioStocks < ActiveRecord::Migration
  def change
    create_table :portfolio_stocks do |t|
      t.references :stock, index: true, foreign_key: true
      t.references :portfolio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
