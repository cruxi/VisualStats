class AddLanguageToVisualJob < ActiveRecord::Migration
  def change
    add_column :visual_jobs, :language, :string
  end
end
