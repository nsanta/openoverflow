class AddTotalPointsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users , :total_points , :integer , :default => 1
  end

  def self.down
    remove_column :users , :total_points
  end
end
