class ChangeDimensionValueType < ActiveRecord::Migration
  def change
    change_column :visual_dimensions, :value, :text
  end
end
