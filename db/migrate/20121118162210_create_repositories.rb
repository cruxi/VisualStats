class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :url
      t.integer :last_duration
      t.timestamp :created_at
      t.timestamp :updated_at
      t.integer :last_build_id
      t.string :last_build_number
      t.integer :last_build_status
      t.timestamp :last_build_started_at
      t.timestamp :last_build_finished_at
      t.string :owner_name
      t.text :owner_email
      t.boolean :active
      t.text :description
      t.string :last_build_language
      t.integer :last_build_duration
      t.boolean :private
      t.integer :owner_id
      t.string :owner_type
      t.integer :last_build_result

      t.timestamps
    end
  end
end
