class CreateGenreRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :genre_relationships do |t|

      t.integer :genre_id
      t.integer :portfolio_id
      t.timestamps
    end
  end
end
