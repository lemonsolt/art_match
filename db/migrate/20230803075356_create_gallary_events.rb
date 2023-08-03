class CreateGallaryEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :gallary_events do |t|

      t.integer :gallary_id
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.text :introduction
      t.integer :recruit
      t.timestamps
    end
  end
end
