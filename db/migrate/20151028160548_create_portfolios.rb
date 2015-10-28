class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.decimal :cash
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
