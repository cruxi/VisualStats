class AddUpdatedAtToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :updated_at, :timestamp
  end
end
