class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.integer :id
      t.text :content
      t.integer :job_id

      t.timestamps
    end
  end
end
