class CreateVisualJobs < ActiveRecord::Migration
  def change
     create_table :visual_jobs do |t|
       t.integer  "build_id"
       t.string   "number"
       t.string   "state"
       t.datetime "finished_at"
       t.text     "tags"
       t.integer  "retries",       :default => 0
       t.boolean  "allow_failures", :default => false
       t.integer  "result"
       t.string   "dimensions"
       t.timestamps
     end
  end


end
