class AddCreatedAtToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :created_at, :timestamp
  end
end
