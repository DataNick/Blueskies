class CreateHistoricalPrices < ActiveRecord::Migration
  def change
    create_table :historical_prices do |t|
      t.references :stock, index: true, foreign_key: true
      t.datetime :date
      t.decimal :day_price_close

      t.timestamps null: false
    end
  end
end
