class CreateEventBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :event_bookmarks do |t|
      
      t.integer :artist_id
      t.integer :event_id
      t.timestamps
    end
  end
end
