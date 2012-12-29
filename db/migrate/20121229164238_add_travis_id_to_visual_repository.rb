class AddTravisIdToVisualRepository < ActiveRecord::Migration
  def change
    add_column :visual_repositories, :travis_id, :integer
  end
end
