class CreateGallaryEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :gallary_events do |t|

      t.integer :gallary_id
      t.string :title
      t.date :start_at
      t.date :end_at
      t.text :introduction
      t.integer :recruit
      t.timestamps
    end
  end
end
