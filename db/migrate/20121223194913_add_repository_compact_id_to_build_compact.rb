class AddRepositoryCompactIdToBuildCompact < ActiveRecord::Migration
  def change
    add_column :build_compacts, :repository_compact_id, :integer
  end
end
