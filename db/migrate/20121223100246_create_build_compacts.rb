class CreateBuildCompacts < ActiveRecord::Migration
  def change
    create_table :build_compacts do |t|
      t.integer :result
      t.timestamp :finished_at
      t.integer :number
      t.string :config

      t.timestamps
    end
  end
end
