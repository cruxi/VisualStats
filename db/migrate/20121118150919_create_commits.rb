class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.integer :repository_id
      t.string :commit
      t.string :ref
      t.string :branch
      t.text :message
      t.string :compare_url
      t.timestamp :committed_at
      t.string :committer_name
      t.string :committer_email
      t.string :author_name
      t.string :author_email
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
