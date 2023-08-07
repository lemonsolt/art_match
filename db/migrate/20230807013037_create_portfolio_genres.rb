class CreatePortfolioGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_genres do |t|
      t.references :portfolio, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end

    add_index :portfolio_genres,[:portfolio_id, :genre_id], unique: true
  end
end
