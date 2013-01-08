class CreateVisualJobs < ActiveRecord::Migration
  def change
     create_table :visual_jobs do |t|
       t.integer  "build_id"
       t.string   "number"
       t.string   "state"
       t.datetime "finished_at"
       t.boolean  "allow_failure", :default => false
       t.integer  "result"
       t.string   "language"
       t.integer  "travis_id"

     end
  end


end
