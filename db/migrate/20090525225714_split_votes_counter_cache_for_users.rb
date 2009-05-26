class SplitVotesCounterCacheForUsers < ActiveRecord::Migration
  def self.up
    add_column :users , :total_votes_up , :integer , :default => 0
    add_column :users , :total_votes_down , :integer , :default => 0
  end

  def self.down
    remove_column :users , :total_votes_up
    remove_column :users , :total_votes_down
  end
end
