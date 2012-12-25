class CreateRepositoryCompacts < ActiveRecord::Migration
  def change
    create_table :repository_compacts do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :owner_name

    end
  end
end
