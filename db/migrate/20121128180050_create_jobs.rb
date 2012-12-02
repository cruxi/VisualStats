class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :id
      t.integer :repository_id
      t.integer :commit_id
      t.integer :source_id
      t.string :source_type
      t.string :queue
      t.string :type
      t.string :state
      t.string :number
      t.text :config
      t.integer :status
      t.string :job_id
      t.string :worker
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :created_at
      t.datetime :updated_at
      t.text :tags
      t.integer :retries
      t.boolean :allow_failure
      t.integer :owner_id
      t.string :owner_type
      t.integer :result
      t.datetime :queued_at

      t.timestamps
    end
  end
end
