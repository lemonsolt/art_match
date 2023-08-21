class CreateGComments < ActiveRecord::Migration[6.1]
  def change
    create_table :g_comments do |t|

      t.integer :gallary_id
      t.string :title
      t.text :comment
      t.timestamps
    end
  end
end
