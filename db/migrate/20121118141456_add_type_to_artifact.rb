class AddTypeToArtifact < ActiveRecord::Migration
  def change
    add_column :artifacts, :type, :string
  end
end
