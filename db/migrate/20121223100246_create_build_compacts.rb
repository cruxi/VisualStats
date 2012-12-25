class CreateBuildCompacts < ActiveRecord::Migration
  def change
    create_table :build_compacts do |t|
      t.integer :result
      t.datetime :finished_at
      t.integer :number
      t.text :config


    end
  end
end
