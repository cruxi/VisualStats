class AddIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :id, :integer
  end
end
