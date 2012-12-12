#VisualTravis
class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.integer :job_info_id
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
