class CreateGtoaFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :gtoa_follows do |t|

      t.integer :artist_id
      t.integer :gallary_id
      t.timestamps
    end
  end
end
