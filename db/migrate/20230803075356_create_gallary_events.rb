class CreateGallaryEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :gallary_events do |t|

      t.integer :gallary_id
      t.string :title
      t.date :start_at,null: false
      t.date :end_at,null: false
      t.text :introduction
      t.integer :recruit, default: 0,null: false
      t.timestamps
    end
  end
end
