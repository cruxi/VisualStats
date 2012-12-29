class CreateVisualDimensions < ActiveRecord::Migration
  def change
    create_table :visual_dimensions do |t|
      t.integer :job_id
      t.string :key
      t.string :value
    end
  end
end
