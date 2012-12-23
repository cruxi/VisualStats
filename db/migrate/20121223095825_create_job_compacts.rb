class CreateJobCompacts < ActiveRecord::Migration
  def change
    create_table :job_compacts do |t|
      t.string :language
      t.string :version
      t.boolean :allow_failure
      t.integer :result
      t.timestamp :finished_at

      t.timestamps
    end
  end
end
