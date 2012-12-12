#VisualTravis
class CreateJobInfos < ActiveRecord::Migration
  def change
    create_table :job_infos do |t|
      t.integer :repository_id
      t.integer :job_id
      t.string :language
      t.string :result
      t.string :integer
      t.string :dimension_keys

      t.timestamps
    end
  end
end
