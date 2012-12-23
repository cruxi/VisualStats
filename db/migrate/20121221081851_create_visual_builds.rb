class CreateVisualBuilds < ActiveRecord::Migration
  def change
    create_table :visual_builds do |t|
# fields build
      t.integer  "repository_id"
      t.string   "number"
      t.datetime "started_at"
      t.datetime "finished_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "request_id"
      t.string   "language"
      t.integer  "duration"
      t.integer  "owner_id"
      t.string   "owner_type"
      t.integer  "result"
      t.integer  "previous_result"

      # additional fields provided in api
      # statt t.integer  "commit_id"
      t.string "commit"

      t.string "build_url"
      t.string "branch"
      t.string "committed_at"
      t.string "author_name"
      t.string "committer_name"

      t.text     "config"


      t.timestamps
    end
  end
end
