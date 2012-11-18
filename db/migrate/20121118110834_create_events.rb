class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :source_id
      t.string :source_type
      t.integer :repository_id
      t.string :event
      t.text :data

      t.timestamps
    end
  end
end
