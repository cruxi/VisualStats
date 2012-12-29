class AddTravisIdToVisualJob < ActiveRecord::Migration
  def change
    add_column :visual_jobs, :travis_id, :integer
  end
end
