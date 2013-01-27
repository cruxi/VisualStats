class SetupCrosstab < ActiveRecord::Migration
  def self.up
    execute "CREATE EXTENSION tablefunc"
  end

  def self.down
    execute "DROP EXTENSION tablefunc"
  end
end
