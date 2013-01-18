class AddTravisIdIndexToBuilds < ActiveRecord::Migration
  def change
      add_index "visual_builds", ["travis_id"], :name => "index_visual_builds_on_travis_id"


  end
end
