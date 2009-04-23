class AddCounterCacheForUserActivity < ActiveRecord::Migration
  def self.up
    add_column :users , :total_votes , :integer , :default => 0
    add_column :users , :total_answers , :integer , :default => 0
    add_column :users , :total_questions , :integer , :default => 0
    add_column :users , :total_tags , :integer , :default => 0
  end

  def self.down
    remove_column :users , :total_votes
    remove_column :users , :total_answers
    remove_column :users , :total_questions
    remove_column :users , :total_tags
  end
end
