class CreateAComments < ActiveRecord::Migration[6.1]
  def change
    create_table :a_comments do |t|

      t.integer :artist_id
      t.string :title
      t.text :comment
      t.timestamps
    end
  end
end
