class AddVoteCounterCacheForAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers , :votes_average , :integer , :default => 0
  end

  def self.down
    add_column :answers , :votes_average
  end
end
