class AddTravisIdToVisualBuild < ActiveRecord::Migration
  def change
    add_column :visual_builds, :travis_id, :integer
  end
end
