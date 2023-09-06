class CreateChatComments < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_comments do |t|

      t.integer :chat_thread_id
      t.integer :artist_id
      t.integer :gallary_id
      t.text :comment
      t.timestamps
    end
  end
end
