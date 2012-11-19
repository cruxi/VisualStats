class AddIdToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :id, :integer
  end
end
