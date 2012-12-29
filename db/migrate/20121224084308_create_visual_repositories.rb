class CreateVisualRepositories < ActiveRecord::Migration
  def change
    create_table :visual_repositories do |t|
      t.string :name
      t.string :owner_name
      t.string :url

    end
  end
end
