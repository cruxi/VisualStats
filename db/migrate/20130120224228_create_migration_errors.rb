class CreateMigrationErrors < ActiveRecord::Migration
  def change
    create_table :migration_errors do |t|
      t.integer :travis_id
      t.text :message
      t.text :stacktrace

      t.timestamps
    end
  end
end
