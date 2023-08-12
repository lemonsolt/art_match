class CreateDmMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :dm_messages do |t|

      t.integer :artist_id
      t.integer :gallary_id
      t.integer :dm_room_id
      t.text :message
      t.timestamps
    end
  end
end
