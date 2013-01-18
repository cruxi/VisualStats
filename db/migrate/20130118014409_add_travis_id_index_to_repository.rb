class AddTravisIdIndexToRepository < ActiveRecord::Migration
  def change
     add_index "visual_repositories", ["travis_id"], :name => "index_visual_repositories_on_travis_id"
  end
end
