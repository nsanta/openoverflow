class AddVoteCounterCacheForQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions , :votes_average , :integer , :default => 0
  end

  def self.down
    remove_column :questions , :votes_average
  end
end
