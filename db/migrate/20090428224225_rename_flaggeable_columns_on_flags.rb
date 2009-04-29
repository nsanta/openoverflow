class RenameFlaggeableColumnsOnFlags < ActiveRecord::Migration
  def self.up
    rename_column :flags , :flaggeagle_id , :flaggeable_id
  end

  def self.down
    rename_column :flags , :flaggeable_id , :flaggeagle_id
  end
end
