class CreatePortfolioBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_bookmarks do |t|

      t.integer :gallary_id
      t.integer :portfolio_id
      t.timestamps
    end
  end
end
