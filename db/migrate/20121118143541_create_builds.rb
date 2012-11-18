class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :id
      t.integer :repository_id
      t.string :number
      t.integer :status
      t.timestamp :started_at
      t.timestamp :finished_at
      t.string :agent
      t.timestamp :created_at
      t.timestamp :updated_at
      t.text :config
      t.integer :commit_id
      t.integer :request_id
      t.string :state
      t.string :language
      t.timestamp :archived_at
      t.integer :duration
      t.integer :owner_id
      t.string :owner_type
      t.integer :result
      t.integer :previous_result
      t.string :event_type

      t.timestamps
    end
  end
end
