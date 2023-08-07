class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      
      t.integer :artist_id
      t.string :title
      t.text :item
      t.text :introduction
      t.timestamps
    end
  end
end
