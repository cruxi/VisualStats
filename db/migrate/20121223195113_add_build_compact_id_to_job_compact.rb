class AddBuildCompactIdToJobCompact < ActiveRecord::Migration
  def change
    add_column :job_compacts, :build_compact_id, :integer
  end
end
